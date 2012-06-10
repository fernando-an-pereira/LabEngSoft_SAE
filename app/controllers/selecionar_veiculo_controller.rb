class SelecionarVeiculoController < ApplicationController
	 
	 
  # GET /selecionar_veiculo
  def index
    @veiculos_de_saude = VeiculoDeSaude.all
    
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @veiculos_de_saude }
  end
  
  def get_Status
	@veiculo = VeiculoDeSaude.find(:first, :conditions => ['"RENAVAM" = ?', params[:RENAVAM]])
	@ocupado = @veiculo.ocupado
	if @ocupado == true
		@veiculo.ocupado = false
		@veiculo.save
	end
	
	respond_to do |format|
		format.json { render json: @veiculo }
    end
	
  end

  
  end
end
