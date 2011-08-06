class Review < ActiveRecord::Base
  belongs_to :service
  belongs_to :user

  validates :group_number, :review,  :presence => true
  
end
