class PacienteController < ApplicationController
  # GET /paciente
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
    end 
  end
  
  # GET /paciente/:id
  def show
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
    end
  end

end
