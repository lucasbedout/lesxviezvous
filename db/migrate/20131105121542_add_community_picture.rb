class AddCommunityPicture < ActiveRecord::Migration
	def change
    	add_column :communities, :picture, :string
  	end
end
