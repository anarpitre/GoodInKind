class Profile < ActiveRecord::Base
  belongs_to  :user
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :profile_social_networks, :dependent => :destroy
  has_many :social_networks, :through => :profile_social_networks
  
  accepts_nested_attributes_for :location, :allow_destroy => true

  validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif", "image/jpg"]
  validates_attachment_size  :avatar, :less_than => 2.megabytes

  # TBD - change size of medium as per HTML layout.
  has_attached_file :avatar,
    :styles => {
    :thumb => "101x95#",
    :medium => "200x200#"
    },
    :default_url => "/images/missing/user_:style.jpg"

end
