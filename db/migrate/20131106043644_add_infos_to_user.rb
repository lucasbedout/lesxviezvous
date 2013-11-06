class AddInfosToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
    add_column :users, :gender, :boolean
    add_column :users, :hobbies, :string
    add_column :users, :languages, :string
    add_column :users, :job, :string
    add_column :users, :website, :string
  end
end
