class Image < ActiveRecord::Base
  belongs_to :service
  
  has_attached_file :image,
    :styles => { :small_thumb => [ "50x50!", :jpg ],
      :medium_thumb => [ "75x75!", :jpg ],
      :carousal => [ "81x81!", :jpg ],
      :large_thumb => [ "120x120>", :jpg ],
      :detail_preview => [ "210x210!", :jpg ]} 
     # :storage => :s3,
      #:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      #:path => ":attachment/:id/:style.:extension",
      #:bucket => 'yourbucket'#size set according to logo size available in xhtmls(brands_review_detail.html)

      #:default_url => "/images/missing/logo/:style.gif"
  #validates_attachment_content_type :logo, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>:logo_format
  #validates_attachment_size :logo, :less_than => 5.megabytes, :message => "Uploaded logo cannot be more than 5 MB"
end
