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
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    mys_clear { redirect_to root_url, :notice => "Logged out!" }
  end
end
