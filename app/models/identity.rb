class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessible :id,:email, :name, :password_digest, :password, :password_confirmation
end
