class PrivateMessagesController < ApplicationController
  def index
    @messages = PrivateMessage.where(recipient_id: current_user.id)
    @message = PrivateMessage.new
  end

  def new
  end

  def create
    message = current_user.message.build(message_params)
  end

  def view
    @message = PrivateMessage.find(params[:message_id])
  end

  private 
    def message_params
      params.require(:message).permit(:message)
    end
end
