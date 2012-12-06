class MessageController < ApplicationController
  def index
    redirect_to root_path unless flash[:message]
    @message=flash[:message]
    flash.clear
  end
end
