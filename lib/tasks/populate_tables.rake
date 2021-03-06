#encoding: utf-8 
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    paciente = Paciente.new(:email => 'paciente@tatu.gov.br', :password => 'paciente', :password_confirmation => 'paciente', :nome => "Paciente de Souza", :CPF => '123.456.789-0', :endereco => "Casa da Tia, 1234")
    paciente.prontuario = Prontuario.new(:data => '04/06/2012', :observacao => 'Paciente de Souza')
    paciente.prontuario.prescricao << Prescricao.new(:nomeMedicamento => 'Guaraná', :dosagem => '12 cápsulas', :frequencia => 'diária')
    paciente.prontuario.prescricao << Prescricao.new(:nomeMedicamento => 'Morte', :dosagem => '1 gota', :frequencia => '1 vez por vida')
    paciente.prontuario.exame << Exame.new(:data => '04/06/2012', :nomeDoLaboratorio => 'Digi', :resultado => 'Stress', :tipo => 'não funciona')
    paciente.prontuario.exame << Exame.new(:data => '05/06/2012', :nomeDoLaboratorio => 'PEA', :resultado => 'Morte', :tipo => 'a de sempre')
    paciente.prontuario.registro_de_emergencium << RegistroDeEmergencium.new(:data => '15/06/2012', :causas => 'Resultado da prova de SO', :gravidade => 'Severa', :localidadeEmergencia => 'POLI')
	paciente.save
    paciente = Paciente.new(:email => 'jose.carvalho@tatu.net', :password => 'tatusecret', :password_confirmation => 'tatusecret', :nome => "Jose Carvalho", :CPF => '059.468.316-60', :endereco => "Rua 4, 2")
    paciente.prontuario = Prontuario.new(:data => '05/06/2012', :observacao => 'Jose Carvalho')
    paciente.prontuario.prescricao << Prescricao.new(:nomeMedicamento => 'Paracetamol', :dosagem => '2 cápsulas', :frequencia => 'diária')
    paciente.prontuario.prescricao << Prescricao.new(:nomeMedicamento => 'Maconha', :dosagem => '1 cigarro', :frequencia => 'nas horas vagas')
    paciente.prontuario.exame << Exame.new(:data => '06/07/2012', :nomeDoLaboratorio => 'Tio João', :resultado => 'Teníase', :tipo => 'exame de fezes')
    paciente.prontuario.registro_de_emergencium << RegistroDeEmergencium.new(:data => '17/06/2012', :causas => 'Overdose de paracetamol.', :gravidade => 'Leve', :localidadeEmergencia => 'Laboratorio Tio Joao')
	paciente.save
	paciente = Paciente.new(:email => 'joao.silva@tatu.net', :password => 'joaosilva', :password_confirmation => 'joaosilva', :nome => "Joao da Silva", :CPF => '234.567.890.1', :endereco => "Rua das Palmeiras, 4")
    paciente.prontuario = Prontuario.new(:data => '07/06/2012', :observacao => 'Joao da Silva')
    paciente.save
    paciente = Paciente.new(:email => 'joao.pereira@tatu.net', :password => 'joaopereira', :password_confirmation => 'joaopereira', :nome => "Joao Pereira", :CPF => '345.678.901.2', :endereco => "Alameda dos Tatus, 17")
    paciente.prontuario = Prontuario.new(:data => '08/06/2012', :observacao => 'Joao Pereira')
    paciente.save
    paciente = Paciente.new(:email => 'joao.souza@tatu.net', :password => 'joaosouza', :password_confirmation => 'joaosouza', :nome => "Joao de Souza", :CPF => '456.789.012.3', :endereco => "Rua das Palmeiras, 22")
    paciente.prontuario = Prontuario.new(:data => '09/06/2012', :observacao => 'Joao de Souza')
    paciente.save
    paciente = Paciente.new(:email => 'maria.santos@tatu.net', :password => 'mariasantos', :password_confirmation => 'mariasantos', :nome => "Maria dos Santos", :CPF => '567.890.123.4', :endereco => "Rua Nova, 7")
    paciente.prontuario = Prontuario.new(:data => '10/06/2012', :observacao => 'Maria dos Santos')
    paciente.save
    paciente = Paciente.new(:email => 'cristina.fernandes@tatu.net', :password => 'cristinafernandes', :password_confirmation => 'cristinafernandes', :nome => "Cristina Fernandes", :CPF => '678.901.234.5', :endereco => "Vila Riacho Azul, 39")
    paciente.prontuario = Prontuario.new(:data => '10/06/2012', :observacao => 'Cristina Fernandes')
    paciente.save
    paciente = Paciente.new(:email => 'maria.carvalho@tatu.net', :password => 'mariacarvalho', :password_confirmation => 'mariacarvalho', :nome => "Maria Carvalho", :CPF => '789.012.345.6', :endereco => "Rua 4, 2")
    paciente.prontuario = Prontuario.new(:data => '12/06/2012', :observacao => 'Maria Carvalho')
    paciente.save
    paciente = Paciente.new(:email => 'carlos.santos@tatu.net', :password => 'carlossantos', :password_confirmation => 'carlossantos', :nome => "Carlos dos Santos", :CPF => '890.123.456.7', :endereco => "Rua Nova, 7")
    paciente.prontuario = Prontuario.new(:data => '13/06/2012', :observacao => 'Carlos dos Santos')
    paciente.save
    paciente = Paciente.new(:email => 'carlos.carvalho@tatu.net', :password => 'carloscarvalho', :password_confirmation => 'carloscarvalho', :nome => "Carlos Carvalho", :CPF => '901.234.567.8', :endereco => "Rua 4, 2")
    paciente.prontuario = Prontuario.new(:data => '13/06/2012', :observacao => 'Carlos Carvalho')
    paciente.save

    medico = Medico.new(:email => 'medico@tatu.gov.br', :password => 'medico', :password_confirmation => 'medico', :nome => "Medico de Souza", :CPF => '111.111.111-9', :endereco => "Casa da Vó, 4321", :CRM => '100.000.000-1')
    medico.save
	medico = Medico.new(:email => 'medico0@tatu.gov.br', :password => 'medico0', :password_confirmation => 'medico0', :nome => "Medico Menezes", :CPF => '222.222.222-7', :endereco => "Avenida da Lebre, 8", :CRM => '200.000.000.2')
    medico.save
    
    atendente = Atendente.new(:email => 'atendente@tatu.gov.br', :password => 'atendente', :password_confirmation => 'atendente', :nome => "Atendente de Souza", :CPF => '999.999.999-1', :endereco => "Casa da Mãe, 123", :CRE => '100.000.000-1')
    atendente.save
    atendente = Atendente.new(:email => 'atendente2@tatu.gov.br', :password => 'atendente2', :password_confirmation => 'atendente2', :nome => "Atendente da Silva", :CPF => '999.999.000-1', :endereco => "Casa da Mãe, 321", :CRE => '100.000.001-1')
    atendente.save
    
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '600000006', :latitude => '-22.116296' , :longitude => '-45.050511', :ocupado => 'true')
    veiculo_de_saude.save
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '700000007', :latitude => '-22.116654' , :longitude => '-45.053129', :ocupado => 'false')
    veiculo_de_saude.save
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '800000008', :latitude => '-22.120829' , :longitude => '-45.052185', :ocupado => 'false')
    veiculo_de_saude.save

  end
end
