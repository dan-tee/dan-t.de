class PrivateMessagesController < ApplicationController
  before_action :redirect_non_admin,   only: [:index, :destroy]

  def new
    @message = PrivateMessage.new
  end

  def create
    @message = PrivateMessage.new(message_params)
    if @message.save
      flash.now[:success] = 'Message sent successfully'
      @message = PrivateMessage.new
    else
      flash.now[:danger] = 'Message could not be sent'
    end

    redirect_to contact_path
  end

  def index
    @messages = PrivateMessage.not_archived
  end

  #should maybe better use update to be RESTful
  def destroy
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
