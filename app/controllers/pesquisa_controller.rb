class PesquisaController < ApplicationController
  # GET /pesquisa
  def index
    @pacientes = Paciente.all
  end
  
  # GET /pesquisa/paciente=:nome
  def search
	condition = params[:nome]
  
	@pacientes = Paciente.all(:order => "nome")
	
	@pacientes.delete_if{ |p| p.nome.exclude? condition }

	render :index
  end

end
