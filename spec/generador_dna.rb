# TODO generarlas random, genericas segun el tamanio de la secuencia que esta en humano.
# Tambien se podria usar property based testing.

class GeneradorDna

  def mutante
    [
      ['A', 'A', 'A', 'A', 'A'],
      ['C', 'T', 'A', 'G', 'A'],
      ['T', 'C', 'A', 'C', 'G'],
      ['A', 'C', 'G', 'T', 'C'],
      ['T', 'C', 'A', 'C', 'G']      
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