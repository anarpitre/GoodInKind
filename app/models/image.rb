class Image < ActiveRecord::Base
  belongs_to :service

  if RAILS_ENV == production
    has_attached_file :image,
      :styles => { :thumb => [ "200x100#", :jpg ], :detail => [ "448x260>", :jpg ]  
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => 'yourbucket',                       
      :default_url => "/images/missing/logo/:style.gif"}
  else
    has_attached_file :image,
      :styles => { :thumb => [ "200x100#", :jpg ], :detail => [ "448x260>", :jpg ] } 
  end

  validates_attachment_content_type :image, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>:logo_format
  validates_attachment_size :image, :less_than => 5.megabytes, :message => "Uploaded logo cannot be more than 5 MB"

end
