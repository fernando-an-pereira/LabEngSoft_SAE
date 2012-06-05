class ShowProntuarioController < ApplicationController
	
	def index
	end
	
	def show
		paciente = Paciente.find(params[:paciente_id])
		@prontuario = Prontuario.find(params[:prontuario_id])
		respond_to do |format|
			format.html
			format.json  { render :json => @prontuario }
		end
	end
end
