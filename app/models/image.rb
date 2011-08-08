class Image < ActiveRecord::Base
  belongs_to :service

  has_attached_file :image, S3_DEFAULTS.merge(
     :styles => { :thumb => [ "200x100#", :jpg ], :detail => [ "448x260>", :jpg ] }
  )

  validates_attachment_content_type :image, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>:logo_format
  validates_attachment_size :image, :less_than => 5.megabytes, :message => "Uploaded logo cannot be more than 5 MB"

end
