class Profile < ActiveRecord::Base

  belongs_to  :user
  has_many :profile_social_networks, :dependent => :destroy
  has_many :social_networks, :through => :profile_social_networks

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_size  :avatar, :less_than => 2.megabytes
  
  has_attached_file :avatar,
    :styles => {
    :thumb=> "100x100#",
    :small  => "400x400>" }
end
