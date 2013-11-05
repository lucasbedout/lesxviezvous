class AddCategoryToCommunitu < ActiveRecord::Migration
  def change
    add_column :communities, :category_id, :integer
  end
end
