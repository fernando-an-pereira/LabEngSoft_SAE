class Medico < Pessoa
  
#  default_scope where(:role => 'medico')
  
  attr_accessible :CRM
  
  has_many :registro_de_emergencia, :foreign_key => "medico_id"
  
end
