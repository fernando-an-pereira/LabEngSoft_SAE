class HomeController < ApplicationController
  
  include TypesHelper
  
  def index
    #definir redirecionamentos para cada um dos usuários
    if(pessoa_signed_in?)
      if(atendente?)
#       redirect_to (current_pessoa)
      elsif(medico?)
#       redirect_to (current_pessoa)
      elsif(paciente?)
#       redirect_to (current_pessoa)
      end
    end
  end
  
end
