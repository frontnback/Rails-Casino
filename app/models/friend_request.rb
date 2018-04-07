class FriendRequest < ApplicationRecord
  def accept
    self.update!(accepted: true)
  end

  # private
  #   def created_friendship
  #     Friendship.create(user_id:)
end
