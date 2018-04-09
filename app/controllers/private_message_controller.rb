class PrivateMessageController < ApplicationController
  def index
    @messages = PrivateMessage.where(recipient_id: current_user.id)
  end

  def create
    message = 
  end

  def view
    @message = PrivateMessage.find(params[:message_id])
  end

  private 
    def message_params
      params.require(:message).permit(:content)
    end
end
