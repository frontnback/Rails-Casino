class FriendsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: current_user.id)
  end  

  def request 
    
  end
end
