class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.boolean :status, :default => 0
      t.integer :upvotes, :default => 0
      t.integer :user_id
      t.integer :community_id

      t.timestamps
    end
  end
end
