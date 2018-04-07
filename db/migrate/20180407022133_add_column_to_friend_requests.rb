class AddColumnToFriendRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :friend_requests, :accepted, :boolean, :default => false
  end
end
