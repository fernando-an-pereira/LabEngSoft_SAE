class Prescricao < ActiveRecord::Base
  attr_accessible :dosagem, :frequencia, :nomeMedicamento
  
  belongs_to :prontuario
end
