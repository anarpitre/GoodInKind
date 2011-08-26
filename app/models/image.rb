class Image < ActiveRecord::Base
  belongs_to :service

  has_attached_file :image, S3_DEFAULTS.merge(
     :styles => { 
     :thumb => "200x100!", 
     :medium => "448x260!"
     }
  )

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png','image/gif', 'image/jpg', 'image/bmp', 'image/tiff', 'image/tif'], :message=>:logo_format
  validates_attachment_size :image, :less_than => 5.megabytes, :message => "Uploaded logo cannot be more than 5 MB"

end
