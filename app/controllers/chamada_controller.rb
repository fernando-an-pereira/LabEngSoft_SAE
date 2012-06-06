require 'thread'

include TypesHelper

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
  
  @solicita = false
  
  def mensagem
    if(@@mensagens[current_pessoa].nil?)
      @@mensagens[current_pessoa] = Array.new
    end
    @mensagens = @@mensagens[current_pessoa]
    respond_to do |format|
      if(paciente? && @solicita) 
        @solicita = false
        format.html { redirect_to esperaConsulta_path(current_pessoa) }
      else
        format.html # mensagem.html.erb
      end
#      format.json { render :json => @mensagens }
    end 
#    @@mensagens[current_pessoa].clear  
  end
  
  def enviarMensagem 
    mensagem1 = Mensagem.new
    mensagem1.remetente = current_pessoa.class
    mensagem2 = Mensagem.new
    mensagem2.remetente = "Eu"
    respond_to do |format|
      mensagem1.conteudo = params[:conteudo]
      mensagem2.conteudo = params[:conteudo]
      appendMensagem(mensagem1, nil)
      appendMensagem(mensagem2, current_pessoa);  
      format.html { redirect_to chamada_path(current_pessoa) }
    end
    
  end
  
  def esperaAtendimento
    @espera = @@pacientesEsperaAtendimento.index(current_pessoa)
    if(@espera.nil?)
      redirect_to chamada_path
    end
  end
  
  def esperaConsulta
    @espera = @@pacientesEsperaConsulta.index(current_pessoa)
    if(@espera.nil?)
      redirect_to chamada_path
    end
  end
  
  def inicia
    if(paciente?)
      solicitaAtendimento(current_pessoa)
      redirect_to esperaAtendimento_path(current_pessoa)
    elsif(atendente?)
      atendenteLivre(current_pessoa)
      redirect_to esperaPaciente_path(current_pessoa)
    elsif(medico?)
      medicoLivre(current_pessoa)
      redirect_to esperaPaciente_path(current_pessoa)
    end
  end
  
  def esperaPaciente
    if (medico?)
      @espera = @@medicosLivres.index(current_pessoa)
      if(@espera.nil?)
        redirect_to chamada_path
      end
    elsif (atendente?)
      @espera = @@atendentesLivres.index(current_pessoa)
      if(@espera.nil?)
        redirect_to chamada_path
      end
    end
  end
  
  def encerrarChamada
    if (medico?)
      medicoLivre(current_pessoa)
      redirect_to chamada_esperaPaciente_path
    elsif (atendente?)
      if(@solicita)
        @@pacienteFuncionario.key(current_pessoa).solicita = true
        solicitaConsulta(@@pacienteFuncionario.key(current_pessoa))
        @solicita = false
      end
      atendenteLivre(current_pessoa)
      redirect_to chamada_esperaPaciente_path
    end
  end
  
  def redirecionaPacienteConsultaVirtual
    @solicita = true
  end
  
  protected
  
  def solicitaAtendimento(paciente)
    if(@@atendentesLivres.empty?)
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
    @@pacienteFuncionario.delete_if{ |key, value| value == atendente }
    if(@@pacientesEsperaAtendimento.empty?)
      @@atendentesLivres << atendente
    else
      paciente = @@pacientesEsperaAtendimento.shift
      @@pacienteFuncionario.merge!({ paciente => atendente })
    end
  end
  
  def medicoLivre(medico)
    @@pacienteFuncionario.delete_if{ |key, value| value == medico }
    if(@@pacientesEsperaConsulta.empty?)
      @@medicosLivres << medico
    else
      paciente = @@pacientesEsperaAtendimento.shift
      @@pacienteFuncionario.merge!({ paciente => medico })
    end
  end
  
  def appendMensagem(mensagem, destinatario)
    if(destinatario.nil?)
      if @@pacienteFuncionario.has_key?(current_pessoa)
        destinatario = @@pacienteFuncionario[current_pessoa]
      else
        destinatario = @@pacienteFuncionario.key(current_pessoa)
      end
    end
    if @@mensagens[destinatario].nil? 
      @@mensagens[destinatario] = Array.new
    end
    @@mensagens[destinatario] << mensagem
  end
  
end
