class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends, :force =>true do |t|
      t.integer :userf_id
      t.integer :usert_id

      t.timestamps null: false
    end
  end
end
