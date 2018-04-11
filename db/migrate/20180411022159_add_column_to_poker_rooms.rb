class AddColumnToPokerRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_rooms, :current_round, :integer
  end
end
