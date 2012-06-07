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
  
  def index
  end
  
  def mensagem
    if(@@mensagens[current_pessoa].nil?)
      @@mensagens[current_pessoa] = Array.new
    end
    @mensagem = @@mensagens[current_pessoa].shift
    respond_to do |format|
      if(paciente? && @solicita) 
        @solicita = false
        format.html { redirect_to esperaConsulta_path(current_pessoa) }
      else
        format.html # mensagem.html.erb
        format.json { render :json => @mensagem }
      end

    end 
#    @@mensagens[current_pessoa].clear  
  end
  
  def enviarMensagem 
    mensagem = Mensagem.new
    mensagem.remetente = current_pessoa.class.to_s
    respond_to do |format|
      conteudo = params.key(nil)
      if (! conteudo.empty?)
        mensagem.conteudo = conteudo
        appendMensagem(mensagem) 
      end
      format.js
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
  
  def appendMensagem(mensagem)
    if @@pacienteFuncionario.has_key?(current_pessoa)
      destinatario = @@pacienteFuncionario[current_pessoa]
    else
      destinatario = @@pacienteFuncionario.key(current_pessoa)
    end
    if @@mensagens[destinatario].nil? 
      @@mensagens[destinatario] = Array.new
    end
    @@mensagens[destinatario] << mensagem
  end
  
end
