class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.integer :fakevotes
      t.integer :user_id
      t.integer :category_id
      t.integer :status
      t.string :source

      t.timestamps
    end
  end
end
