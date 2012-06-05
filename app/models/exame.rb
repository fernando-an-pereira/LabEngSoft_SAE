class Exame < ActiveRecord::Base
  attr_accessible :data, :nomeDoLaboratorio, :resultado, :tipo
  
  belongs_to :prontuario
end
