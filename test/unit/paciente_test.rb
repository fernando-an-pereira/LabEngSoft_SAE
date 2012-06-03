require 'test_helper'

class PacienteTest < ActiveSupport::TestCase
  paciente = Paciente.new(:email => 'coringa@tatu.gov.br', :password => '0a0a0abc', :password_confirmation => '0a0a0abc', :nome => "Coringa da Souza", :CPF => '123.456.789-0', :endereco => "Casa da Tia, 1234")
  paciente.save
end
