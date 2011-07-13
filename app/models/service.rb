class Service < ActiveRecord::Base
  
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :participants
  has_many :users, :through => :participants
  has_many :images, :dependent => :destroy
  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories
  
  validates :title,:description, :amount, :charity_id, :priority, :presence => true
  validates :start_date,:end_date,:start_time,:end_time,:if => Proc.new { |t| t.is_scheduled == true}, :presence => true

end
