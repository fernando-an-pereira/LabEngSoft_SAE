class Paciente < Pessoa

  default_scope where(:role => 'paciente')
  
  has_one :prontuario, :autosave => true
  
end
