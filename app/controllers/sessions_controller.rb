#encoding: UTF-8
class SessionsController < ApplicationController
  def new
  end
  def create
    filter=EmailOrSite.new params[:email1], request.protocol
    user = User.where("#{filter.type}=?", filter.to_s).first
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      mys_setup user do
        redirect_to office_root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    mys_clear { redirect_to root_url, :notice => "Logged out!" }
  end

  def reset
      session[:logged][:user] = session[:logged][:master].dup
      flash[:success]="Relogado para a conta #{current_user.subdomain}!"
      redirect_to :back
  end

  def switch
      if user=User.where(id:params[:id],auth_token:params[:token]).first
        session[:logged][:user][:id]=user.id
        session[:logged][:user][:token]=user.auth_token
        flash[:success]="Sublogado na conta #{user.subdomain}!"
        redirect_to :office_root
      else
        flash[:error]="Sublogin informa: Usuário não encontrado!"
        redirect_to :back
      end
  end
end
