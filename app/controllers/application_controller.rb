#encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :uri, :session_expires


  private

  def current_user
    return false unless is_logged?
    @current_user ||= User.find_by_auth_token!(session[:logged][:user][:token])
  end

  def current_master
    return current_user unless is_sublogged?
    @current_master ||= User.find_by_auth_token!(session[:logged][:master][:token])
  end

  helper_method :current_user, :current_master

  def authorize
    redirect_to login_url, alert: "Not authorized" unless is_logged?
  end

  def sponsor
    @sponsor ||= User.member(request.subdomains.last)
  end
  helper_method :sponsor

  def uri
    if sponsor.subdomain != request.subdomains.last
      site=MySub.new request, sponsor
      redirect_to site.url
    else
      unless session[:visit]
      sponsor.visit_counter.inc
      session[:visit]={}
      session[:visit][:sponsor_id] = 1
      session[:visit][:redir_from] = params[:redir_from] if params[:redir_from].presence
      end
    end
  end


  # helpers to manage logged user
    def mys_setup current, &block
      user={id:current.id, token:current.auth_token}
      timer=Time.now
      session[:logged]={user: user, master: user.dup, timer: timer}
      block.call
    end

    def mys_clear &block
      cookies.delete(:auth_token)
      session[:logged]=nil
      block.call
    end

    def is_logged?
      !!session[:logged].presence
    end

    def is_sublogged?
      return false unless is_logged?
      session[:logged][:user] != session[:logged][:master]
    end
    helper_method :is_logged?, :is_sublogged?
  #

  def session_expires
    if is_logged?
      @timer=(Time.now - session[:logged][:timer]) / 60
      if @timer > 15
        mys_clear { redirect_to login_path, :notice => "Sessão expirou!" }
      else
        session[:logged][:timer]=Time.now
      end
    end
  end


end
