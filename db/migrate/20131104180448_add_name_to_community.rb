class AddNameToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :name, :string
  end
end
