class Friendship < ApplicationRecord
  # after_create :create_inverse_relationship
  # after_destroy :destroy_inverse_relationship

  belongs_to :user

  private 
    # def create_inverse_relationship
    #   Friendship.create(user_id: self.user_id, friend_user_id: self.friend_user_id)
    # end

    # def destroy_inverse_relationship
    #   Friendship.find(user_id: self.user_id, friend_user_id: self.friend_user_id).destroy
    # end
end
