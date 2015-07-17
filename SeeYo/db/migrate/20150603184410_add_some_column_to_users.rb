class AddSomeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :messages_unread , :int, :default => 0;
    add_column :users, :circle_unread , :int, :default => 0;
    add_column :users, :zone_unread , :int, :default => 0;
  end
end
