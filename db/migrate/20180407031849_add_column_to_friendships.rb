class AddColumnToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :id, :primary_key
  end
end
