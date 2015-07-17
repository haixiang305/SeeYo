class AddAvatarAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :is_admin, :boolean, :default => false
  end
end
