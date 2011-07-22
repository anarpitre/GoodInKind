class Service < ActiveRecord::Base
  
  has_one :location, :as => :resource,:dependent => :destroy

  has_many :user_service_role
  has_many :participants, :class_name => 'UserServiceRole', :conditions => ["role = 'Participant'"],:dependent => :destroy
  has_one :offerer, :class_name => 'UserServiceRole', :conditions => ["role = 'Offerer'"], :dependent => :destroy
  #has_many :users, :through => :user_service_role
  has_many :users, :through => :participants
  
  has_many :images, :dependent => :destroy

  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories

  validates :title,:description, :offerer_id,:non_profit_id, :is_public, :presence => true
  validates :amount, :numericality => true, :presence => true
  validates :start_date,:end_date,:start_time,:end_time,:if => Proc.new { |t| t.is_scheduled == true}, :presence => true

end
