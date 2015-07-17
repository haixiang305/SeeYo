class AddUsernameToInformation < ActiveRecord::Migration
  def change
    add_column :information, :avatar, :string
    add_column :information, :username, :string
    remove_column :users, :username
    remove_column :users, :avatar
  end
end
