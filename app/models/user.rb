class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_inkwell_user
  
  # attr_accessible :title, :body
  has_many :posts
end
