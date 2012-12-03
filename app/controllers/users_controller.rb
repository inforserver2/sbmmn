class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit!)
    @user.sponsor_id = sponsor.id
    if @user.save
      session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
