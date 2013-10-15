class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :title, :default => 'Novice'
      t.integer :points, :default => 0
      t.integer :rank, :default => 0

      t.timestamps
    end
  end
end
