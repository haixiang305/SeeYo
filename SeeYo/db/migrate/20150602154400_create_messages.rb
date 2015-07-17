class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :classes
      t.integer :msg_id
      t.integer :sender_id
      t.text :content

      t.timestamps null: false
    end
  end
end
