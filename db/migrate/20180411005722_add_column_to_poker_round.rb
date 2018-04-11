class AddColumnToPokerRound < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_rounds, :poker_room_id, :integer
  end
end
