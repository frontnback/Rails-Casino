class AddCurrentGameColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_game, :integer
  end
end
