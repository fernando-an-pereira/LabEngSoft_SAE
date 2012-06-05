class RegistroDeEmergencium < ActiveRecord::Base
  attr_accessible :causas, :data, :gravidade, :localidadeEmergencia
  
  belongs_to :prontuario
  belongs_to :atendente
  belongs_to :medico
end
