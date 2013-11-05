class AddLargepictureToUser < ActiveRecord::Migration
  def change
    add_column :users, :picture_large, :string
  end
end
