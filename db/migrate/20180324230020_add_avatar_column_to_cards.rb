class AddAvatarColumnToCards < ActiveRecord::Migration[5.1]
  def up
    add_attachment :cards, :avatar
  end

  def down 
    remove_attachment :cards, :avatar
  end
end
