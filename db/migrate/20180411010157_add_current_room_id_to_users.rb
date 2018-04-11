class AddCurrentRoomIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_room, :integer
  end
end
