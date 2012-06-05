class Prontuario < ActiveRecord::Base
  attr_accessible :data, :observacao
  
  belongs_to :paciente
  has_many :registro_de_emergencium
  has_many :prescricao
  has_many :exame
end
