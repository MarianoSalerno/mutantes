require "pry"
# Que pasa si hay 5 iguales seguidas? cuentan como 2 secuencias? voy a asumir que si

# Si la matriz tiene algo que no sea A T C o G rompo
# Agarro una posicion cualquiera
class Humano

  #TODO proveer alguna forma para cambiar estos valores sin tocar el codigo (ej: variables de entorno con dotenv)
  def self.tamanio_secuencia
    4
  end

  def self.cantidad_para_cumplir
    2
  end

  def self.caracteres_validos
    ['A', 'T', 'C', 'G']
  end

  def initialize(dna)
    @dna = dna
    @cantidad_de_secuencias = 0
  end

  def mutante?
    validar()

    @dna.each_with_index do |fila, posicion|
      fila.each_with_index do |casillero, i|
        lugar_derecha = (fila.length - i) >= self.class.tamanio_secuencia
        lugar_abajo = (@dna.length - posicion) >= self.class.tamanio_secuencia
        lugar_izquierda = (fila.length - i) < self.class.tamanio_secuencia

        #Chequeo horizontal
        if lugar_derecha
          incrementar_cantidad_de_secuencias([fila[i], fila[i+1], fila[i+2], fila[i+3]], casillero)
          return true if cumple_condicion?
        end
        
        #Chequeo vertical
        if lugar_abajo
          incrementar_cantidad_de_secuencias([@dna[posicion][i], @dna[posicion+1][i], @dna[posicion+2][i], @dna[posicion+3][i]], casillero)
          return true if cumple_condicion?
        end
        
        #Chequeo diagonal derecha
        if lugar_derecha && lugar_abajo
          incrementar_cantidad_de_secuencias([@dna[posicion][i], @dna[posicion+1][i+1], @dna[posicion+2][i+2], @dna[posicion+3][i+3]], casillero)
          return true if cumple_condicion?
        end
        
        #Chequeo diagonal izquierda
        if lugar_izquierda && lugar_abajo
          incrementar_cantidad_de_secuencias([@dna[posicion][i], @dna[posicion+1][i-1], @dna[posicion+2][i-2], @dna[posicion+3][i-3]], casillero)
          return true if cumple_condicion?
        end

      end
    end

    return false

  end

  private

  def validar
    raise CaracterInvalido unless @dna.flatten.all?{|caracter| self.class.caracteres_validos.include?(caracter)}
    raise TamanioInvalido unless @dna.all?{|secuencia| secuencia.length == @dna.length && secuencia.length == @dna[0].length && secuencia.length >= self.class.tamanio_secuencia }
  end

  def incrementar_cantidad_de_secuencias(array_a_chequear, casillero)
    @cantidad_de_secuencias += 1 if array_a_chequear.take_while{|c| c == casillero}.length >= self.class.tamanio_secuencia
  end

  def cumple_condicion?
    @cantidad_de_secuencias >= self.class.cantidad_para_cumplir
  end

end

class CaracterInvalido < StandardError
  def message
    "se encontro un caracter invalido en el DNA"
  end
end

class TamanioInvalido < StandardError
  def message
    "la matriz debe ser de NxN y mayor o igual a #{TAMANIO_SECUENCIA}x#{TAMANIO_SECUENCIA}"
  end
end