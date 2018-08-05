# TODO generarlas random, genericas segun el tamanio de la secuencia que esta en humano.
# Tambien se podria usar property based testing.

class GeneradorDna

  def mutante_fila
    ['AAAAA', 'CTAGA', 'TCACG', 'ACGTC', 'TCACG']
  end

  def mutante_columna
    ['CATAA', 'CTAGA', 'CCACG', 'CCGTC', 'CCACG']
  end

  def mutante_diagonal_derecha
    ['TATAA', 'ATAGA', 'TCTCG', 'GCGTC', 'CCACT']
  end

  def mutante_diagonal_izquierda
    ['CATAA', 'ACAGA', 'TCCCG', 'GCGCC', 'CCACC']
  end

  def no_mutante
    ['AAACT', 'CTCCC', 'TTACG', 'ACGGG', 'TCCCC']
  end

  def invalido
    ['AAAAA','CTAGA','TCACG','ACGTC','TCAC2']  
  end

  def dimensiones_incorrectas
    ['AAAA']
  end

end