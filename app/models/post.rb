class Post < ActiveRecord::Base
  attr_accessible :category_id, :content, :downvotes, :fakevotes, :source, :status, :title, :upvotes, :user_id
  belongs_to :category
  belongs_to :user
  has_many :comments, :as => :commentable
  acts_as_inkwell_post
  validates_presence_of :category_id, :content

  def self.user(id)
  	 if User.find_by_uid(id).blank? 
  	 	User.find(id) 
  	 else 
  	 	User.find_by_uid(id)
  	 end 
  end
end
