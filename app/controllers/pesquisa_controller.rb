class PesquisaController < ApplicationController
  # GET /pacientes
  # GET /pacientes.json
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pacientes }
    end 
  end
  
  # GET /pacientes/1
  # GET /pacientes/1.json
  def sample
	condition = Paciente.find(params[:id])
  
	@rol = Paciente.all
	@pacientes = nil
	
	@rol.each do |t|
		if t.include? condition
			@pacientes << t
		end
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pacientes }
    end
  end

end
