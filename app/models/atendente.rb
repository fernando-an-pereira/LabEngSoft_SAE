class Atendente < Pessoa

#  default_scope where(:role => 'atendente')
  
  attr_accessible :CRE
  
  has_many :registro_de_emergencia, :foreign_key => "atendente_id"
  
end
