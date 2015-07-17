class CreateInfoInterests < ActiveRecord::Migration
  def change
    create_table :info_interests do |t|
      t.integer :information_id
      t.integer :interest_id

      t.timestamps null: false
    end
  end
end
