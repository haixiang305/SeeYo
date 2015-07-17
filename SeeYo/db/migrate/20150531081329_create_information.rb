class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information, :force =>true do |t|
      t.integer :user_id
      t.string :gender
      t.string :location
      t.text :about
      t.date :birthday
      t.string :blog

      t.timestamps null: false
    end
  end
end
