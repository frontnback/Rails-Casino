class InvitationController < ApplicationController
  def index
  end

  def transmit
    @invitation = Invitation.new(sender_id: current_user.id, recipient_id: params[:friend_id])
    if @invitation.save
      ActionCable.server.broadcast "invitations_channel_#{params[:friend_id]}",
                                    invitation: @invitation,
                                    inviter: User.find(@invitation.sender_id).username

      return @invitation                            
    end
  end
end
