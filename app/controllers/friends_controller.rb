class FriendsController < ApplicationController
  def index
    friendships = Friendship.where(user_id: current_user.id)
    @friends = friendships.map { |f| User.find(f.friend_user_id) }
    @incoming = FriendRequest.where(requested_id: current_user)
    # @incoming = incoming.map { |u| User.find(u.sender_id) }
  end  

  # def send_friend_request
  #   FriendRequest.create(sender_id: current_user.id)
  # end
end
