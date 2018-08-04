# TODO generarlas random, genericas segun el tamanio de la secuencia que esta en humano.
# Tambien se podria usar property based testing.

class GeneradorDna

  def mutante_fila
    [
      ['A', 'A', 'A', 'A', 'A'],
      ['C', 'T', 'A', 'G', 'A'],
      ['T', 'C', 'A', 'C', 'G'],
      ['A', 'C', 'G', 'T', 'C'],
      ['T', 'C', 'A', 'C', 'G']      
    ]  
  end

  def mutante_columna
    [
      ['C', 'A', 'T', 'A', 'A'],
      ['C', 'T', 'A', 'G', 'A'],
      ['C', 'C', 'A', 'C', 'G'],
      ['C', 'C', 'G', 'T', 'C'],
      ['C', 'C', 'A', 'C', 'G']      
    ]  
  end

  def mutante_diagonal_derecha
    [
      ['T', 'A', 'T', 'A', 'A'],
      ['A', 'T', 'A', 'G', 'A'],
      ['T', 'C', 'T', 'C', 'G'],
      ['G', 'C', 'G', 'T', 'C'],
      ['C', 'C', 'A', 'C', 'T']      
    ]  
  end

  def mutante_diagonal_izquierda
    [
      ['C', 'A', 'T', 'A', 'A'],
      ['A', 'C', 'A', 'G', 'A'],
      ['T', 'C', 'C', 'C', 'G'],
      ['G', 'C', 'G', 'C', 'C'],
      ['C', 'C', 'A', 'C', 'C']      
    ]  
  end

  def no_mutante
    [
      ['A', 'A', 'A', 'C', 'T'],
      ['C', 'T', 'C', 'C', 'C'],
      ['T', 'T', 'A', 'C', 'G'],
      ['A', 'C', 'G', 'G', 'G'],
      ['T', 'C', 'C', 'C', 'C']
    ]  
  end

  def invalido
    [
      ['A', 'A', 'A', 'A', 'A'],
      ['C', 'T', 'A', 'G', 'A'],
      ['T', 'C', 'A', 'C', 'G'],
      ['A', 'C', 'G', 'T', 'C'],
      ['T', 'C', 'A', 'C', '2']
    ]  
  end

  def dimensiones_incorrectas
    ['A', 'A', 'A', 'A']
  end

end