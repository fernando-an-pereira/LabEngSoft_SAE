module RolesHelper

  def medico?
    current_pessoa.role == 'medico'
  end
  
  def atendente?
    current_pessoa.role == 'atendente'
  end
  
  def paciente?
    current_pessoa.role == 'paciente'
  end
  
end
