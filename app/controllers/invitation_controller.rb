class InvitationController < ApplicationController
  def index
  end

  def transmit
    @invitation = Invitation.new(sender_id: current_user.id, recipient_id: params[:friend_id])
    if @invitation.save
      ActionCable.server.broadcast "invitations_channel_#{params[:friend_id]}",
                                    inviter: current_user.username
    end
  end
end
