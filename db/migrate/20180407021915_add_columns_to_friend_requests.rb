class AddColumnsToFriendRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :friend_requests, :sender_id, :integer
    add_column :friend_requests, :requested_id, :integer
  end
end
