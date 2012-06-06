class Prontuario < ActiveRecord::Base
  attr_accessible :data, :observacao
  
  belongs_to :paciente
<<<<<<< HEAD
  has_many :registro_de_emergencia
  has_many :prescricaos
  has_many :exames
=======
  has_many :registro_de_emergencium, :foreign_key => "prontuario_id"
  has_many :prescricao, :foreign_key => "prontuario_id"
  has_many :exame, :foreign_key => "prontuario_id"
>>>>>>> a77f7a93459ba783be1721af76265262bb688a23
end
