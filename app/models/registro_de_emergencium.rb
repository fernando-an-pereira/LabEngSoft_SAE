class RegistroDeEmergencium < ActiveRecord::Base
  attr_accessible :causas, :data, :gravidade, :localidadeEmergencia
  
  validates :localidadeEmergencia,	:presence => true
  
  belongs_to :prontuario
  belongs_to :atendente
  belongs_to :medico
  belongs_to :veiculo_de_saude
end
