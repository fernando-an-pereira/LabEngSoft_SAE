#encoding: utf-8 
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    paciente = Paciente.new(:email => 'paciente@tatu.gov.br', :password => 'paciente', :password_confirmation => 'paciente', :nome => "Paciente de Souza", :CPF => '123.456.789-0', :endereco => "Casa da Tia, 1234")
    paciente.save

    medico = Medico.new(:email => 'medico@tatu.gov.br', :password => 'medico', :password_confirmation => 'medico', :nome => "Medico de Souza", :CPF => '111.111.111-9', :endereco => "Casa da Vó, 4321", :CRM => '100.000.000-1')
    medico.save

    atendente = Atendente.new(:email => 'atendente@tatu.gov.br', :password => 'atendente', :password_confirmation => 'atendente', :nome => "Atendente de Souza", :CPF => '999.999.999-1', :endereco => "Casa da Mãe, 123", :CRE => '100.000.000-1')
    atendente.save
    
  end
end
