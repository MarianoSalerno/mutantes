# Que pasa si hay 5 iguales seguidas? cuentan como 2 secuencias? voy a asumir que si

# Si la matriz tiene algo que no sea A T C o G rompo
# Agarro una posicion cualquiera
# Me fijo si para la derecha tiene al menos 3 casilleros
# Comparo y corto cuando encuentro uno distinto y llego al final
# Si llegue al final sumo 1 a la cantidad de hits
# Si la cantidad de hits es 2 o mas devuelvo true
# Hago lo mismo para abajo
# Hago lo mismo para la diagonal derecha
# Hago lo mismo para la diagonal izquierda
# Si llegue al final devuelvo false

# Quizas queda mejor si delego la comparacion de las secuencias en una aux que reciba los subindices

# Casos de prueba:
# 2 secuencias horizontales
# 2 secuencias verticales
# 2 diagonales derechas
# 2 diagonales izquierdas
# Horizontal y diagonal derecha
# Vertical y diagonal izquierda
# Tirar excepcion si la matriz no tiene los caracteres permitidos

class Humano

  #TODO proveer alguna forma para cambiar estos valores sin tocar el codigo 
  TAMANIO_SECUENCIA = 4
  CANTIDAD_PARA_CUMPLIR = 2
  CARACTERES_VALIDOS = ['A', 'T', 'C', 'G']

  @cantidad_de_secuencias = 0

  def mutante?(dna)
    # Si tuviese mas tiempo me gustaria probar si esto queda mejor generando las permutaciones de antemano
    dna.each_with_index do |fila, posicion|
      fila.each_with_index do |casillero, i|
        # TODO hacer que la generacion del array a chequear sea generica para todos los tamaños

        raise CaracterInvalido.new(posicion) unless CARACTERES_VALIDOS.include?(posicion)

        #Chequeo horizontal
        if (casillero.length - i) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([fila[i], fila[i+1], fila[i+2], fila[i+3]])
          return true if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end
        
        #Chequeo vertical
        if (dna.length - posicion) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i], dna[posicion+2][i], dna[posicion+3][i]])
          return true if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end
        
        #Chequeo diagonal derecha
        if (casillero.length - i) >= TAMANIO_SECUENCIA && (dna.length - posicion) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i+1], dna[posicion+2][i+2], dna[posicion+3][i+3]])
          return true if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end
        
        #Chequeo diagonal izquierda
        if (i > TAMANIO_SECUENCIA) && posicion > TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i-1], dna[posicion+2][i-2], dna[posicion+3][i-3]])
          return true if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end

      end
    end

    return false

  end

  private

  def incrementar_cantidad_de_secuencias array_a_chequear
    @cantidad_de_secuencias += 1 if array_a_chequear.take_while{|c| c == casillero]}.length >= TAMANIO_SECUENCIA
  end

end

class CaracterInvalido < StandardError

  def initialize(caracterErroneo)
    @caracterErroneo = caracterErroneo
  end

  def message
    "se encontro el caracter invalido #{@caracterErroneo} en el DNA"
  end
end