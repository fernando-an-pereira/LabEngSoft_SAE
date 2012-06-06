class RegistroDeEmergencium < ActiveRecord::Base
  attr_accessible :causas, :data, :gravidade, :localidadeEmergencia
  
  belongs_to :prontuario
  belongs_to :atendente, :class_name => "Pessoa"
  belongs_to :medico, :class_name => "Pessoa"
end
