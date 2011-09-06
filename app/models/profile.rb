class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :location, :as => :resource,:dependent => :destroy
  
  accepts_nested_attributes_for :location, :allow_destroy => true
  accepts_nested_attributes_for :user, :reject_if => proc { |attributes| attributes['password'].blank? }

  validates :first_name, :last_name, :presence => true

  has_attached_file :avatar, S3_DEFAULTS.merge(
    :styles => {
    :thumb => "101x95>",
    :medium => "200x200>"
    },
    :default_url => "/images/missing/user_:style.png"
    )

  validates_attachment_size :avatar, :less_than => 2.megabytes, :message => "file size should be less than 2MB"

  validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif", "image/jpg", "image/bmp", "image/tiff", "image/tif","image/pjp    eg", "image/x-png" ], :message=> "Invalid image, image format should be jpeg/ jpg/ png/ gif"


  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def update_fb_image(username)
    filename = "/tmp/#{username}.jpg"
    temp = File.open(filename, 'wb') do |f|
      f.write(FirstGiving.get("http://graph.facebook.com/#{username}/picture?type=large", :format => :binary).body)
    end

    File.open(filename, 'rb') do |f|
      self.avatar = f
    end

    self.save!

    File.unlink(filename)

    rescue Exception
      # Ignore all errors
  end

end
