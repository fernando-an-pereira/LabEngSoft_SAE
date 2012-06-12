class SelecionarVeiculoController < ApplicationController
	 
	 
  # GET /selecionar_veiculo
  def index
    @veiculos_de_saude = VeiculoDeSaude.all
   
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @veiculos_de_saude }
  end
  
  def get_Status
	@veiculo = VeiculoDeSaude.find(:first, :conditions => ['"RENAVAM" like ?', params[:ren]])
	@ocupado = @veiculo.ocupado
	if @ocupado == false
		render :inline => "false"
	else
		render :inline => "true"
	end
  end
  
  def set_Ocupado
    @veiculo = VeiculoDeSaude.find(:first, :conditions => ['"RENAVAM" like ?', params[:ren]])
	@ocupado = @veiculo.ocupado
	if @ocupado == false
		@veiculo.ocupado = true
		@veiculo.save
		@resultado = VeiculoDeSaude.all
		render :json => @resultado
	else
		render :inline => "false"
	end
  end

  def atualiza_Status
	@resultado = VeiculoDeSaude.all
	render :json => @resultado
  end

  end
end
