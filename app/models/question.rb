class Question < ActiveRecord::Base
  attr_accessible :community_id, :status, :text, :upvotes, :user_id
  has_many :answers
  belongs_to :user
  belongs_to :community

  validates_presence_of :text, :on => :create, :message => "Une question vide n'est pas une question"
end
