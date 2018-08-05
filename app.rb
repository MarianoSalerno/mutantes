require "sinatra"
require "json"
require_relative 'lib/humano'

post '/mutant/' do
  # TODO si no es json valido devolver un error indicandolo
  data = JSON.parse request.body.read
  logger.info "procesando DNA: #{data["dna"]}"
  es_mutante = Humano.new(data["dna"]).mutante?
  es_mutante ? 200 : 403
end