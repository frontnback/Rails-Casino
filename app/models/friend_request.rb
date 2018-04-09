class FriendRequest < ApplicationRecord
  validates_uniqueness_of :sender_id, scope: :requested_id
  validates_uniqueness_of :requested_id, scope: :sender_id
  # def accept
  #   self.update!(accepted: true)
  # end

  # private
  #   def created_friendship
  #     Friendship.create(user_id:)
end
