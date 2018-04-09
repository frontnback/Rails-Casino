class AddColumnsToPrivateMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :private_messages, :user_id, :integer
  end
end
