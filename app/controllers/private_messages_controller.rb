class PrivateMessagesController < ApplicationController
  before_action :redirect_non_admin,   only: [:index, :update]

  def new
    @message = PrivateMessage.new
  end

  def create
    @message = PrivateMessage.new(message_params)
    if @message.save
      flash[:success] = 'Message sent successfully'
      @message = PrivateMessage.new
      redirect_to contact_path
    else
      flash.now[:danger] = 'Message could not be sent'
      render action: :new
    end
  end

  def index
    @messages = PrivateMessage.not_archived
  end

  def update
    message = PrivateMessage.find(params[:id])
    message.update_attribute(:archived, true)

    flash[:success] = 'Message moved to archive'
    redirect_to private_messages_path
  end

  private

  def message_params
    params.require(:private_message).permit(:name, :email, :message)
  end
end
