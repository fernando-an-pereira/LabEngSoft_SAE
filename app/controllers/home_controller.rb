class HomeController < ApplicationController
  
  include TypesHelper
  
  def index
    #definir redirecionamentos para cada um dos usuários
    if(pessoa_signed_in?)
      if(atendente?)
       redirect_to chamada_enviarMensagem_path
      elsif(medico?)
       redirect_to chamada_enviarMensagem_path
      elsif(paciente?)
       redirect_to chamada_enviarMensagem_path
      end
    end
  end
  
end
