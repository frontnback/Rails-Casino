class FriendsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: current_user.id)
  end  

  # def send_friend_request
  #   FriendRequest.create(sender_id: current_user.id)
  # end
end
