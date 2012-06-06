class Prontuario < ActiveRecord::Base
  attr_accessible :data, :observacao
  
  belongs_to :paciente
  has_many :registro_de_emergencium, :foreign_key => "prontuario_id"
  has_many :prescricao, :foreign_key => "prontuario_id"
  has_many :exame, :foreign_key => "prontuario_id"
end
