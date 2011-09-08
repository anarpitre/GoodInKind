class Image < ActiveRecord::Base
  belongs_to :service

  has_attached_file :image, S3_DEFAULTS.merge(
     :styles => { 
     :thumb => "200x133>", 
     :medium => "450x300>"
     }
  )

  validate :check_dimensions
  validates_attachment_content_type :image, 
    :content_type => ["image/jpeg", "image/png", "image/gif", "image/jpg", "image/bmp", "image/tiff", "image/tif","image/pjpeg", "image/x-png" ]

  def check_dimensions
    tempfile = self.image.queued_for_write[:original]
    dimensions = Paperclip::Geometry.from_file(tempfile)
    unless tempfile.nil?
      self.errors.add(:image_file_size, "Please upload a larger landscape image (min. 255w X 150h)")  if ((dimensions.width < 255) || (dimensions.height < 150) || (dimensions.width < dimensions.height) || (dimensions.width > (dimensions.height * 2)))
    end
  end
end
