#encoding: utf-8 
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '600000006', :latitude => '-22.116296' , :longitude => '-45.050511', :ocupado => 'true')
    veiculo_de_saude.save
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '700000007', :latitude => '-22.116654' , :longitude => '-45.053129', :ocupado => 'false')
    veiculo_de_saude.save
    veiculo_de_saude = VeiculoDeSaude.new(:RENAVAM => '800000008', :latitude => '-22.120829' , :longitude => '-45.052185', :ocupado => 'false')
    veiculo_de_saude.save

  end
end