#encoding: utf-8 
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
  
  #
  @@solicita = Array.new
  
  def index
    if (medico? || atendente?)
      respond_to do |format|
        @paciente = @@pacienteFuncionario.key(current_pessoa)
        format.html
      end
    end
  end
  
  def mensagem
    if(@@mensagens[current_pessoa].nil?)
      @@mensagens[current_pessoa] = Array.new
    end
    respond_to do |format|
      if(paciente? && @@solicita.include?(current_pessoa)) 
        @@solicita.delete(current_pessoa)
        format.json { render :json => { :redirect => esperaConsulta_path(current_pessoa) } }
      else
        conteudo = ""
        remetente = @@mensagens[current_pessoa][0].remetente
        @@mensagens[current_pessoa].each do |mensagem|
          conteudo += "#{mensagem.conteudo} <br>"
        end
        @@mensagens[current_pessoa].clear  
        @mensagem = Mensagem.new
        @mensagem.conteudo = conteudo
        @mensagem.remetente = remetente
#        format.html # mensagem.html.erb
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
    respond_to do |format|
      @espera = @@pacientesEsperaAtendimento.index(current_pessoa)
      format.html
      if(@espera.nil?)
        format.html { redirect_to chamada_path(current_pessoa) }
        format.json { render :json => { :redirect => chamada_path(current_pessoa) } }
      else
        format.html
        format.json { render :json => { :espera => @espera + 1 } }
      end
    end
  end
  
  def esperaConsulta
    respond_to do |format|
      @espera = @@pacientesEsperaConsulta.index(current_pessoa)
      format.html
      if(@espera.nil?)
        format.html { redirect_to chamada_path(current_pessoa) }
        format.json { render :json => { :redirect => chamada_path(current_pessoa) } }
      else
        format.html
        format.json { render :json => { :espera => @espera + 1 } }
      end
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
      respond_to do |format|
        @espera = @@medicosLivres.index(current_pessoa)
        if(@espera.nil?)
          format.html { redirect_to chamada_path(current_pessoa) }
          format.json { render :json => { :redirect => chamada_path(current_pessoa) } }
        else
          format.json { render :json => { :espera => @espera + 1 } }
          format.html
        end
      end
    elsif (atendente?)
      respond_to do |format|
        @espera = @@atendentesLivres.index(current_pessoa)
        format.html
        if(@espera.nil?)
          format.html { redirect_to chamada_path(current_pessoa) }
          format.json { render :json => { :redirect => chamada_path(current_pessoa) } }
        else
          format.html
          format.json { render :json => { :espera => @espera + 1 } }
        end
      end
    end
  end
  
  def encerrarChamada
    if (atendente? && @@solicita.include?(current_pessoa))
      @@solicita << @@pacienteFuncionario.key(current_pessoa)
      solicitaConsulta(@@pacienteFuncionario.key(current_pessoa))
      @@solicita.delete(current_pessoa)
    end
    redirect_to inicia_chamada_path
  end
  
  def redirecionaPacienteConsultaVirtual
    respond_to do |format|
      @@solicita << current_pessoa
      format.js
    end
  end
  
  def teste
    respond_to do |format|
      @solicita = @@solicita.include?(current_pessoa)
      if paciente?
        format.json { render :json => { :solicita => @solicita } }
        #format.json { render :json => { :atendente => @@pacienteFuncionario[current_pessoa].email, :solicita => @solicita } }
      else
        format.json { render :json => { :solicita => @solicita } }
        #format.json { render :json => { :paciente => @@pacienteFuncionario.key(current_pessoa).email, :solicita => @solicita } }
      end
    end
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
      while (paciente.nil?)
        @@pacientesEsperaAtendimento.shift
      end
      @@pacienteFuncionario.merge!({ paciente => atendente })
    end
  end
  
  def medicoLivre(medico)
    @@pacienteFuncionario.delete_if{ |key, value| value == medico }
    if(@@pacientesEsperaConsulta.empty?)
      @@medicosLivres << medico
    else
      paciente = @@pacientesEsperaConsulta.shift
#      while (! paciente.logged_in?)
#        paciente = @@pacientesEsperaConsulta.shift
#      end
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
