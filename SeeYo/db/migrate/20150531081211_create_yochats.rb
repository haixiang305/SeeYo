class CreateYochats < ActiveRecord::Migration
  def change
    create_table :yochats, :force =>true do |t|
      t.integer :user_id
      t.string :share_with
      t.integer :like
      t.text :content
      
      t.timestamps null: false
    end
  end
end
