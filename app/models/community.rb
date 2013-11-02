class Community < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_inkwell_community
end
