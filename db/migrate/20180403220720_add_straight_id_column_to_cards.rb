class AddStraightIdColumnToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :straight_id, :integer
  end
end
