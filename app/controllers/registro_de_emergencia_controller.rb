class RegistroDeEmergenciaController < ApplicationController
  # GET /paciente/1/registro_de_emergencia
  def index
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencia = @paciente.prontuario.registro_de_emergencium

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /paciente/1/registro_de_emergencia/1
  def show
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  # GET /paciente/1/registro_de_emergencia/new
  def new
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencium = RegistroDeEmergencium.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # GET /registro_de_emergencia/1/edit
  def edit
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])
  end
  
  # POST /paciente/1/registro_de_emergencia
  def create
	@paciente = Paciente.find(params[:paciente_id])
	@registro_de_emergencium = RegistroDeEmergencium.new(params[:registro_de_emergencium])
    @paciente.prontuario.registro_de_emergencium << @registro_de_emergencium

    respond_to do |format|
      if @paciente.save
        format.html { redirect_to paciente_registro_de_emergencium_path(@paciente, @registro_de_emergencium), notice: 'Registro de emergencia criado com sucesso.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  # PUT /registro_de_emergencia/1
  def update
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])

    respond_to do |format|
      if @registro_de_emergencium.update_attributes(params[:registro_de_emergencium])
        if current_pessoa.type == "Medico"
			format.html { redirect_to chamada_path(current_pessoa), notice: 'Registro de emergencia atualizado com sucesso.' }
		else 
			format.html { redirect_to paciente_registro_de_emergencium_path(@paciente, @registro_de_emergencium), notice: 'Registro de emergencia atualizado com sucesso.' }
		end;
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /registro_de_emergencia/1
  def destroy
	@paciente = Paciente.find(params[:paciente_id])
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])
    @registro_de_emergencium.destroy

    respond_to do |format|
      format.html { redirect_to paciente_registro_de_emergencia_path(@paciente) }
    end
  end
  
  def answer
  end
end
