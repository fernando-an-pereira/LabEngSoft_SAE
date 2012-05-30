class PesquisaController < ApplicationController
  # GET /pesquisa
  def index
    @pacientes = Paciente.all
    
    if @pacientes.nil?
		@paciente = Paciente.new
	else
		@paciente = @pacientes.first
	end

    respond_to do |format|
      format.html # index.html.erb
    end 
  end
  
  # GET /pesquisa/paciente=:nome
  def search
	condition = @paciente.find(params[:nome])
  
	@rol = Paciente.all
	@pacientes = nil
	
	@rol.each do |t|
		if t.include? condition
			@pacientes << t
		end
	end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
