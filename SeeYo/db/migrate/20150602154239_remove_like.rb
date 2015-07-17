class RemoveLike < ActiveRecord::Migration
  def change
    remove_column :yochats, :like
  end
end
