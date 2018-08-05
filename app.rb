require "sinatra"
require "json"
require "redis"
require_relative 'lib/humano'

# TODO mover todo lo relativo a estadisticas a un objeto aparte para no repetir la logica de redis y tener todo encapsulado

post '/mutant/' do
  # TODO si no es json valido devolver un error indicandolo
  data = JSON.parse request.body.read
  logger.info "procesando DNA: #{data["dna"]}"
  es_mutante = Humano.new(data["dna"]).mutante?
  begin
    actualizar_estadisticas(es_mutante)
  rescue StandardError => e
    logger.error(e.message)
    logger.error(e.backtrace)
  end
  es_mutante ? 200 : 403
end

get '/stats/' do
  redis = Redis.new
  begin 
    cantidad_mutantes = obtener_valor_numerico(redis, "count_mutant_dna")
    cantidad_humanos = obtener_valor_numerico(redis, "count_human_dna")
    ratio = obtener_valor_numerico(redis, "ratio")
  rescue StandardError => e
    logger.error(e.message)
    halt 503, "hubo un error al conectarse a redis"
  end

  JSON.generate({count_mutant_dna: cantidad_mutantes, count_human_dna: cantidad_humanos, ratio: ratio})
end

def actualizar_estadisticas(es_mutante)
  # TODO usar variables de entorno para proveer informacion de conexion, esto solo sirve para defaults
  redis = Redis.new
  cantidad_mutantes = obtener_valor_numerico(redis, "count_mutant_dna")
  cantidad_humanos = obtener_valor_numerico(redis, "count_human_dna") + 1

  # Uso redis.multi para que todas las operaciones que esten dentro del bloque se ejecuten atomicamente
  redis.multi do 
    if(es_mutante)
      cantidad_mutantes+=1
      redis.set('count_mutant_dna', cantidad_mutantes)
    end
    redis.set('count_human_dna', cantidad_humanos)

    redis.set("ratio", cantidad_mutantes / cantidad_humanos)
  end
end

def obtener_valor_numerico(redis, key)
  (redis.get(key) || 0).to_f
end