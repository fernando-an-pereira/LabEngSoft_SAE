module TypesHelper

  def medico?
    current_pessoa.instance_of? Medico
  end
  
  def atendente?
    current_pessoa.instance_of? Atendente
  end
  
  def paciente?
    current_pessoa.instance_of? Paciente
  end
  
end
