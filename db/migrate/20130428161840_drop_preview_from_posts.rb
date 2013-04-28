class DropPreviewFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :preview
  end

  def down
    add_column :posts, :preview, :text
  end
end
