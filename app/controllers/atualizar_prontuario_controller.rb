class AtualizarProntuarioController < ApplicationController

#	def index
#		@prontuario = Prontuario.all
#		respond_to do |format|
#			format.html
#			format.jason {render :json => @prontuario}
#		end
#	end
	
	def create
		@prontuario =  Prontuario.find(params[:prontuario_id)
		@registro_de_emergencia = @prontuario.registro_de_emergencia.create(params[:registro_de_emergencia])
		redirect_to atualizar_prontuario_path(@prontuario)
	end
end
