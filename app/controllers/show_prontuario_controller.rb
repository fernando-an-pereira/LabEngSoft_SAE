class ShowProntuarioController < ApplicationController
	
	def index
	end
	
	def show
		paciente = Paciente.find(params[:paciente_id])
		@prontuario = paciente.prontuario
		@exames = paciente.prontuario.exame
		respond_to do |format|
			format.html
		end
	end
end
