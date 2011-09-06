class Image < ActiveRecord::Base
  belongs_to :service

  has_attached_file :image, S3_DEFAULTS.merge(
     :styles => { 
     :thumb => "200x133>", 
     :medium => "450x300>"
     }
  )

  validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/png", "image/gif", "image/jpg", "image/bmp", "image/tiff", "image/tif","image/pjp    eg", "image/x-png" ]

end
