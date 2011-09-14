class Review < ActiveRecord::Base
  belongs_to :service
  belongs_to :user

  validates :group_number, :review,  :presence => true
    
  scope :get_reviews, lambda {|service_id| where("service_id = ?",service_id).order("created_at DESC")}

  scope :active, :conditions => {:active => true}

  scope :for_user, lambda{|user_id| where('services.user_id' => user_id, :is_active => true).joins(:service).order('created_at DESC')}

  after_save :update_count

  def update_count
    offerer = self.service.user.profile
    offerer.total_reviews = offerer.total_reviews.to_i + 1
    offerer.positive_reviews = offerer.positive_reviews.to_i + 1 if self.is_positive
    offerer.save
    Notifier.review_posted(self.service.user.email,self.service.permalink).deliver
  end
end
