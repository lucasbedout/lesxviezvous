class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :upvotes, :default => 0
      t.integer :downvotes, :default => 0
      t.integer :fakevotes, :default => 0
      t.integer :user_id
      t.integer :category_id
      t.integer :status, :default => 0
      t.string :source

      t.timestamps
    end
  end
end
