class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_inkwell_user
  searchkick autocomplete: ['username']

  attr_accessible :username, :email, :password, :password_confirmation, :picture, :birthdate, :gender, :hobbies, :languages,  :job, :website

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  has_many :posts
end
