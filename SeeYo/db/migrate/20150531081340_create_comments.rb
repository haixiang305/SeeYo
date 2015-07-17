class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, :force =>true do |t|
      t.integer :user_id
      t.integer :yochat_id
      t.integer :ater_id
      t.text :content
      t.integer :like

      t.timestamps null: false
    end
  end
end
