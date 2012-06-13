class VeiculoDeSaude < ActiveRecord::Base
  attr_accessible :RENAVAM, :latitude, :longitude, :ocupado
  
  has_many :registro_de_emergencia
end
