class RegistroDeEmergencium < ActiveRecord::Base
  attr_accessible :causas, :data, :gravidade, :localidadeEmergencia
end
