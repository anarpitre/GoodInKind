class Review < ActiveRecord::Base
  belongs_to :service
  belongs_to :user

  validates :group_number, :review,  :presence => true
    
  scope :get_reviews, lambda {|service_id| where("service_id = ?",service_id).order("created_at DESC")}
  
end
