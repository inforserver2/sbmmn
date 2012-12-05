class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit!)
    @user.sponsor_id = sponsor.id
    @user.profile_redir_from = session[:visit][:redir_from] || nil
    if @user.save
      cookies[:auth_token] = @user.auth_token
      mys_setup @user do
        redirect_to root_url, notice: "Thank you for signing up!"
      end
    else
      render "new"
    end
  end
end
