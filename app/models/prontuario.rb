class Prontuario < ActiveRecord::Base
  attr_accessible :data, :observacao
  
  belongs_to :paciente
  has_many :registro_de_emergencia
  has_many :prescricaos
  has_many :exames
end
