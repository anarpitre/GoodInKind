class Service < ActiveRecord::Base
  
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :participants
  has_many :users, :through => :participants

  
  validates :title,:description, :amount, :charity_id, :priority, :presence => true
  validates :start_date,:end_date,:start_time,:end_time,:if => Proc.new { |t| t.is_scheduled == true}, :presence => true

  has_attached_file :logo, 
    :styles => { :small_thumb => [ "50x50!", :jpg ],
      :medium_thumb => [ "75x75!", :jpg ],
      :carousal => [ "81x81!", :jpg ],
      :large_thumb => [ "120x120>", :jpg ],
      :detail_preview => [ "210x210!", :jpg ]},#size set according to logo size available in xhtmls(brands_review_detail.html)

      :default_url => "/images/missing/logo/:style.gif"
  #validates_attachment_content_type :logo, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>:logo_format
  #validates_attachment_size :logo, :less_than => 5.megabytes, :message => "Uploaded logo cannot be more than 5 MB"
end
