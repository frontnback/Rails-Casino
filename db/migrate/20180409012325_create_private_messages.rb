class CreatePrivateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :private_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :message

      t.timestamps
    end
  end
end
