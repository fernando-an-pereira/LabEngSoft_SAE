class Prontuario < ActiveRecord::Base
  attr_accessible :data, :observacao
  
  belongs_to :paciente
end
