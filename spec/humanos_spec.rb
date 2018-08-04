require_relative "spec_helper"
require_relative "../lib/humano"
require_relative "generador_dna"

RSpec.describe "Humanos" do
  let(:generador_dna){
    GeneradorDna.new
  }

  it "deberia ser mutante si el DNA tiene #{Humano.cantidad_para_cumplir} o mas secuencias validas en fila" do
    expect(Humano.new(generador_dna.mutante_fila).mutante?).to be true
  end

  it "deberia ser mutante si el DNA tiene #{Humano.cantidad_para_cumplir} o mas secuencias validas en columna" do
    expect(Humano.new(generador_dna.mutante_columna).mutante?).to be true
  end

  it "deberia ser mutante si el DNA tiene #{Humano.cantidad_para_cumplir} o mas secuencias validas en diagonal derecha" do
    expect(Humano.new(generador_dna.mutante_diagonal_derecha).mutante?).to be true
  end

  it "deberia ser mutante si el DNA tiene #{Humano.cantidad_para_cumplir} o mas secuencias validas en diagonal izquierda" do
    expect(Humano.new(generador_dna.mutante_diagonal_izquierda).mutante?).to be true
  end

  it "no deberia ser un mutante si el DNA tiene menos de #{Humano.cantidad_para_cumplir} secuencias validas" do
    expect(Humano.new(generador_dna.no_mutante).mutante?).to be false
  end

  it "deberia tirar error si hay algun caracter invalido en el DNA" do
    expect{Humano.new(generador_dna.invalido).mutante?}.to raise_error(CaracterInvalido)
  end
  
  it "deberia tirar error si las dimensiones de la matriz son incorrectas" do
    expect{Humano.new(generador_dna.dimensiones_incorrectas).mutante?}.to raise_error(TamanioInvalido)
  end
end