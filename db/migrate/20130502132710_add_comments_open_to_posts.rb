class AddCommentsOpenToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_open, :boolean
  end
end
