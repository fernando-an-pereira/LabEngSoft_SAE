class SelecionarVeiculoController < ApplicationController
  # GET /selecionar_veiculo
  def index
    @veiculos_de_saude = VeiculoDeSaude.all
    
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @veiculos_de_saude }
  end
  end
end
