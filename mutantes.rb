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

  TAMANIO_SECUENCIA = 4
  CANTIDAD_PARA_CUMPLIR = 2

  @cantidad_de_secuencias = 0

  def mutante?(dna)

    dna.each_with_index do |fila, posicion|
      fila.each_with_index do |casillero, i|
        if (casillero.length - i) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias(array_a_chequear)
          return if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end

        if (dna.length - posicion) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i], dna[posicion+2][i], dna[posicion+3][i]])
          return if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end

        if (casillero.length - i) >= TAMANIO_SECUENCIA && (dna.length - posicion) >= TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i+1], dna[posicion+2][i+2], dna[posicion+3][i+3]])
          return if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end
        
        if (i > TAMANIO_SECUENCIA) && posicion > TAMANIO_SECUENCIA
          incrementar_cantidad_de_secuencias([dna[posicion][i], dna[posicion+1][i-1], dna[posicion+2][i-2], dna[posicion+3][i-3]])
          return if @cantidad_de_secuencias >= CANTIDAD_PARA_CUMPLIR
        end

      end
    end

  end

  private

  def incrementar_cantidad_de_secuencias array_a_chequear
    @cantidad_de_secuencias += 1 if array_a_chequear.take_while{|c| c == casillero]}.length >= TAMANIO_SECUENCIA
  end

end