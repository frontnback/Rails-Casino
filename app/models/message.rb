class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :poker_room_id, presence: true
  scope :for_display, -> { order(:created_at).last(50) }
end
