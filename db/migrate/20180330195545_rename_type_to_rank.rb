class RenameTypeToRank < ActiveRecord::Migration[5.1]
  def change
    rename_column :cards, :type, :rank
  end
end
