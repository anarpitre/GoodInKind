class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :location, :as => :resource,:dependent => :destroy
  
  accepts_nested_attributes_for :location, :allow_destroy => true

  validates :first_name, :last_name, :presence => true

  has_attached_file :avatar,
    :styles => {
    :thumb => "101x95>",
    :medium => "200x200>"
    },
    :default_url => "/images/missing/user_:style.jpg"

  validates_attachment_size :avatar, :less_than => 2.megabytes, :message => "file size should be less than 2MB"

  validates_attachment_content_type :avatar, :content_type => ['image/jpg', 'image/pjpeg', 'image/jpeg', 'image/png','image/x-png','image/gif'], :message=> "Invalid image, image format should be jpeg/ jpg/ png/ gif"


  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
