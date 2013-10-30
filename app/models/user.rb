class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :title, :points, :rank, :picture, :picture_large
  has_many :posts

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.picture = auth["info"]["image"]
      if auth["provider"] == "facebook"
        user.picture_large = auth["info"]["image"].split("=")[0] << "=large"
      elsif auth["provider"] == "twitter"
        user.picture_large = auth["info"]["image"].sub("_normal", "")
      end
    end
  end
end
