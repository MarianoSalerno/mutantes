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

  def mutante?(dna)
    tamanio_secuencia = 4
    cantidad_de_secuencias = 0
    dna.each_with_index do |fila, posicion|
      fila.each_with_index do |casillero, i|
        if (casillero.length - i) >= tamanio_secuencia
          #Esto se puede hacer generico y mejor con un take while quizas, si me devuelve la cantidad que saco
          cantidad_de_secuencias += 1 if casillero == fila[i+1] && casillero == fila[i+2] && casillero == fila[i+3]
          return if cantidad_de_secuencias >= 2
        end

        if (dna.length - posicion) >= tamanio_secuencia
          #Esto se puede hacer generico y mejor con un take while quizas, si me devuelve la cantidad que saco
          cantidad_de_secuencias += 1 if casillero == dna[posicion+1][i] && casillero == dna[posicion+2][i] && casillero == dna[posicion+3][i]
          return if cantidad_de_secuencias >= 2
        end

        if (casillero.length - i) >= tamanio_secuencia && (dna.length - posicion) >= tamanio_secuencia
          # Quizas pueda armar un array con la secuencia diagonal y manejarlo mas feliz
          cantidad_de_secuencias += 1 if casillero == dna[posicion+1][i+1] && casillero == dna[posicion+2][i+2] && casillero == dna[posicion+3][i+3]
          return if cantidad_de_secuencias >= 2
        end

        if (i > tamanio_secuencia) && posicion > tamanio_secuencia
          # Quizas pueda armar un array con la secuencia diagonal y manejarlo mas feliz
          cantidad_de_secuencias += 1 if casillero == dna[posicion+1][i-1] && casillero == dna[posicion+2][i-2] && casillero == dna[posicion+3][i-3]
          return if cantidad_de_secuencias >= 2
        end

      end
    end
  end

end