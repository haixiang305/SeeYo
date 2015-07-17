class AddSomeColumnToUsers2 < ActiveRecord::Migration
  def change
    add_column :users, :yochat_unread , :int, :default => 0;
  end
end
