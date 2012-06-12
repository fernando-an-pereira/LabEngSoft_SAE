class ShowProntuarioController < ApplicationController
	
	def index
	end
	
	def show
	#	@paciente = ChamadaController.pacienteFuncionario.key(current_pessoa);
		@paciente = Paciente.find(params[:id])
		@prontuario = @paciente.prontuario
		@exames = @paciente.prontuario.exame
		@registros = @paciente.prontuario.registro_de_emergencium
		@medicamentos = @paciente.prontuario.prescricao
		respond_to do |format|
			format.html
		end
	end
end
