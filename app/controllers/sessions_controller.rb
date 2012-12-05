class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email1(params[:email1])
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
