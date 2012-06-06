require 'thread'

class ChamadaController < ApplicationController
  
  # São utilizados Arrays e não Queues
  # pois a classe Queue não possui o método index.
  # Os métodos utilizados pelos Arrays simulam
  # a utilização de Queues.
  
  @@pacientesEsperaAtendimento = Array.new
  @@pacientesEsperaConsulta = Array.new
  @@atendentesLivres = Array.new
  @@medicosLivres = Array.new
  
  # Hash contendo { destinatario => [mensagens ainda não enviadas a esse destinatário] }
  @@mensagens = Hash.new
  
  # Hash que mapeia { paciente => atendente/medico com quem está se comunicando }
  @@pacienteFuncionario = Hash.new
  
  def mensagem
    if(@@mensagens[current_pessoa].nil?)
      @@mensagens[current_pessoa] = Array.new
    end
    ##############################
      mensagem = Mensagem.new
      mensagem.remetente = current_pessoa
      mensagem.conteudo = "Oi, eu sou o Goku"
      @@mensagens[current_pessoa] << mensagem
      mensagem = Mensagem.new
      mensagem.remetente = current_pessoa
      mensagem.conteudo = "Raaaaaaaa"
      @@mensagens[current_pessoa] << mensagem
      mensagem = Mensagem.new
      mensagem.remetente = current_pessoa
      mensagem.conteudo = "Pegadinha do Malandro"
      @@mensagens[current_pessoa] << mensagem
    ##############################  
    @mensagens = @@mensagens[current_pessoa]
    respond_to do |format|
      format.html # mensagem.html.erb
#      format.json { render :json => @mensagens }
    end 
    @@mensagens[current_pessoa].clear  
  end
  
  def enviarMensagem 
    @mensagem = Mensagem.new
    @mensagem.remetente = current_pessoa  
    respond_to do |format|
      format.html
      @mensagem.conteudo = params[:conteudo]
#      appendMensagem(@mensagem)
    end  
  end
  
  def esperaAtendimento
    espera = @@pacientesEsperaAtendimento.index(current_pessoa)
  end
  
  def esperaConsulta
    espera = @@pacientesEsperaConsulta.index(current_pessoa)
  end
  
  protected
  
  def solicitaAtendimento(paciente)
    if(@@atedentesLivres.empty?)
      @@pacientesEsperaAtendimento << paciente
    else
      atendente = @@atendentesLivres.shift
      @@pacienteFuncionario.merge!({ paciente => atendente })
    end
  end
  
  def solicitaConsulta(paciente)
    if(@@medicosLivres.empty?)
      @@pacientesEsperaConsulta << paciente
    else
      medico = @@medicosLivres.shift
      @@pacienteFuncionario.merge!({ paciente => medico })
    end
  end
  
  def atendenteLivre(atendente)
    if(@@pacientesEsperaAtendimento.empty?)
      @@atendentesLivres << atendente
    else
      paciente = @@pacientesEsperaAtendimento.shift
      @@pacienteFuncionario.merge!({ paciente => atendente })
    end
  end
  
  def medicoLivre(medico)
    if(@@pacientesEsperaConsulta.empty?)
      @@medicosLivres << medico
    else
      paciente = @@pacientesEsperaAtendimento.shift
      @@pacienteFuncionario.merge!({ paciente => medico })
    end
  end
  
  def appendMensagem
    if @@pacienteFuncionario.has_key?(current_pessoa)
      destinatario = @@pacienteFuncionario[current_pessoa]
    else
      destinatario = @@pacienteFuncionario.key(current_pessoa)
    end
    if @@mensagens[destinatario].nil? 
      @@mensagens[destinatario] = Array.new
    end
    @@mensagens[destinatario] << @mensagem
  end
  
end
