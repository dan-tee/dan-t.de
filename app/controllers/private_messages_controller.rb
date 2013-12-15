class PrivateMessagesController < ApplicationController
  def new
  end

  def create
    @message = PrivateMessage.new(message_params)
    if @message.save
      flash.now[:success] = 'Message sent successfully'
      @message = PrivateMessage.new
    else
      flash.now[:danger] = 'Message could not be sent'
    end

    render 'main_pages/contact'
  end

  def index
  end

  private

  def message_params
    params.require(:private_message).permit(:name, :email, :message)
  end
end
