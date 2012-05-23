class RegistroDeEmergenciaController < ApplicationController
  # GET /registro_de_emergencia
  # GET /registro_de_emergencia.json
  def index
    @registro_de_emergencia = RegistroDeEmergencium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registro_de_emergencia }
    end
  end

  # GET /registro_de_emergencia/1
  # GET /registro_de_emergencia/1.json
  def show
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registro_de_emergencium }
    end
  end

  # GET /registro_de_emergencia/new
  # GET /registro_de_emergencia/new.json
  def new
    @registro_de_emergencium = RegistroDeEmergencium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registro_de_emergencium }
    end
  end

  # GET /registro_de_emergencia/1/edit
  def edit
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])
  end

  # POST /registro_de_emergencia
  # POST /registro_de_emergencia.json
  def create
    @registro_de_emergencium = RegistroDeEmergencium.new(params[:registro_de_emergencium])

    respond_to do |format|
      if @registro_de_emergencium.save
        format.html { redirect_to @registro_de_emergencium, notice: 'Registro de emergencium was successfully created.' }
        format.json { render json: @registro_de_emergencium, status: :created, location: @registro_de_emergencium }
      else
        format.html { render action: "new" }
        format.json { render json: @registro_de_emergencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registro_de_emergencia/1
  # PUT /registro_de_emergencia/1.json
  def update
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])

    respond_to do |format|
      if @registro_de_emergencium.update_attributes(params[:registro_de_emergencium])
        format.html { redirect_to @registro_de_emergencium, notice: 'Registro de emergencium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registro_de_emergencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registro_de_emergencia/1
  # DELETE /registro_de_emergencia/1.json
  def destroy
    @registro_de_emergencium = RegistroDeEmergencium.find(params[:id])
    @registro_de_emergencium.destroy

    respond_to do |format|
      format.html { redirect_to registro_de_emergencia_url }
      format.json { head :no_content }
    end
  end
end
