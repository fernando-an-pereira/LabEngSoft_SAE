class Medico < Pessoa
  
  default_scope where(:role => 'medico')
  
  attr_accessible :CRM

end
