class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :preview
      t.text :body
      t.string :icon

      t.timestamps
    end
  end
end
