class VeiculoDeSaude < ActiveRecord::Base
  attr_accessible :RENAVAM, :latitude, :longitude, :ocupado
end
