class RemoveColumnFromCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :name, :string
  end
end
