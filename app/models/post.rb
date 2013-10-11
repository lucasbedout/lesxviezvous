class Post < ActiveRecord::Base
  attr_accessible :category_id, :content, :downvotes, :fakevotes, :source, :status, :title, :upvotes, :user_id

  validates_presence_of :category_id, :content
end
