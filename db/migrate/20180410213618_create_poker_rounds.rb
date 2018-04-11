class CreatePokerRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :poker_rounds do |t|
      t.integer :player1
      t.integer :player2
      t.integer :player3
      t.integer :player4
      t.integer :player5
      t.integer :player6
      t.integer :player7
      t.integer :player8
      t.integer :pot
      t.integer :winner_id

      t.timestamps
    end
  end
end
