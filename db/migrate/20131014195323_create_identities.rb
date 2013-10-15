class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :title, :default => 'Novice'
      t.integer :points, :default => 0
      t.integer :rank, :default => 0

      t.timestamps
    end
  end
end
