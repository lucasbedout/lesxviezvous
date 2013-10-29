class Post < ActiveRecord::Base
  attr_accessible :category_id, :content, :downvotes, :fakevotes, :source, :status, :title, :upvotes, :user_id
  belongs_to :category
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :category_id, :content
end
