#encoding: UTF-8
class PasswordResetsController < ApplicationController
  def new
  end
  def create
    filter=EmailOrSite.new params[:email1], request.protocol
    user = User.where("#{filter.type}=?", filter.to_s).first
    if user
      user.send_password_reset if user
      message="Esta sendo enviado um email com os dados para completar a troca de sua senha, verifique em seu email #{user.email1}."
    else
      message="Usuário não encontrado! Verifique os dados informados e tente novamente."
    end
      flash[:message] = message
      redirect_to message_index_path
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Solicitação de alteração de senha expirada!, caso ainda seja necessário solicite novamente pelo site."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Senha foi trocada!"
    else
      render :edit
    end
  end
end
