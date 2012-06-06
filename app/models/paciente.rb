class Paciente < Pessoa

#  default_scope where(:role => 'paciente')
  
  has_one :prontuario, :foreign_key => "paciente_id", :autosave => true
  
end
