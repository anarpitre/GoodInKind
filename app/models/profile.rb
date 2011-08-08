class Profile < ActiveRecord::Base
  belongs_to  :user
  has_many :profile_social_networks, :dependent => :destroy
  has_many :social_networks, :through => :profile_social_networks

  validates_numericality_of :age

  validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_size  :avatar, :less_than => 2.megabytes

  # FIXME: why is it whiny?
  has_attached_file :avatar, :whiny => false,
    :styles => {
    :thumb=> "100x100#",
    :small  => "400x400>" }

end
