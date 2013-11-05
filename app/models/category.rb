class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :posts
  has_many :communities
end
