class AddColumnsToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :type, :string
    add_column :cards, :suit, :string
    add_column :cards, :value, :integer
  end
end
