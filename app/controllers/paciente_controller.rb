class PacienteController < ApplicationController
  # GET /paciente
  # GET /paciente.json
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pacientes }
    end
  end

  # GET /paciente/1
  # GET /paciente/1.json
  def show
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paciente }
    end
  end

  # GET /paciente/new
  # GET /paciente/new.json
  def new
    @paciente = Paciente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paciente }
    end
  end

  # GET /paciente/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /paciente
  # POST /paciente.json
  def create
    @paciente = Paciente.new(params[:paciente])

    respond_to do |format|
      if @paciente.save
        format.html { redirect_to @paciente, notice: 'Paciente registrado com sucesso.' }
        format.json { render json: @paciente, status: :created, location: @paciente }
      else
        format.html { render action: "new" }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paciente/1
  # PUT /paciente/1.json
  def update
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      if @paciente.update_attributes(params[:paciente])
        format.html { redirect_to @paciente, notice: 'Paciente atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paciente/1
  # DELETE /paciente/1.json
  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy

    respond_to do |format|
      format.html { redirect_to paciente_url }
      format.json { head :no_content }
    end
  end
end
