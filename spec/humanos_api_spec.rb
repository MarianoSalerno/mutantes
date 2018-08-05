require "json"
require 'pry'
require_relative "spec_helper"
require_relative "generador_dna"

describe "Humanos api" do
  let(:generador_dna){
    GeneradorDna.new
  }

  # TODO los post tiran 404, ver porque
  # it "devuelve 200 si el dna provisto es mutante" do
  #   post '/mutant/', JSON.generate(dna: generador_dna.mutante_fila)
  #   expect(last_response.status).to be 200
  # end

  # it "devuelve 403 si el dna provisto no es mutante" do
  #   post '/mutant/', JSON.generate(dna: generador_dna.no_mutante)
  #   expect(last_response.status).to be 403
  # end
end