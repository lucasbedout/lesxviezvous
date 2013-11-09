class Answer < ActiveRecord::Base
  attr_accessible :question_id, :status, :text, :upvotes, :user_id
  belongs_to :question
  belongs_to :user

  validates_presence_of :text, :on => :create, :message => "Impossible de repondre une reponse vide ?"
end
