class ProfileSocialNetwork < ActiveRecord::Base
  belongs_to :profile
  belongs_to :social_network
end
