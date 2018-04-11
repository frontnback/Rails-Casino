class RemoveCurrentGameColumnFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :current_game, :integer
  end
end
