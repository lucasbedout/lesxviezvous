class AddInfosToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :place, :string
    add_column :communities, :description, :text
  end
end
