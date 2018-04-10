class AddColumnToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :poker_room_id, :integer
  end
end
