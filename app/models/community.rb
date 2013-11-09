class Community < ActiveRecord::Base
  attr_accessible :name, :owner_id, :public, :category_id, :picture, :place, :description
  belongs_to :category
  has_many :questions
  acts_as_inkwell_community
end
