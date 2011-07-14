class SocialNetwork < ActiveRecord::Base

  has_many :profile_social_networks, :dependent => :destroy
  has_many :profiles , :through => :profile_social_networks

  validates :name , :presence => true, :uniqueness => true

end
