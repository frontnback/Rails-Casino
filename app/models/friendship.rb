class Friendship < ApplicationRecord
  # after_create :create_inverse_relationship
  # after_destroy :destroy_inverse_relationship

  belongs_to :user

  # private 
  #   def create_inverse_relationship
  #     Friendships.create(friend:)
end
