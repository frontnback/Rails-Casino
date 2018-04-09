class FriendRequestsController < ApplicationController
  # before_action :set_friend_request, except: [:index, :create]

  def create
    requestee = User.find(params[:friend_id].to_i)
    @friend_request = FriendRequest.new(sender_id: current_user.id, requested_id: requestee.id)
    if @friend_request.save
      ActionCable.server.broadcast "notifications_channel_#{requestee.id}",
                                    content: current_user.username
      # ActionCable.server.broadcast "notifications_channel_#{requestee.id}",
      #   message: "#{requestee.username} has sent you a friend request!"
    end
  end

  def index
    @incoming = FriendRequest.where(requested_id: current_user)
  end

  def accept
    Friendship.create(user_id: params[:id], friend_user_id: params[:friend])
    FriendRequest.find(params[:request_id]).destroy
  end

  # private

  #   def set_friend_request
  #     @friend_request = FriendRequest.find(params[:id])
  #   end
end
