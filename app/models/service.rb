class Service < ActiveRecord::Base
  
  has_permalink :title
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :user_service_role
  has_many :participants, :class_name => 'UserServiceRole', :conditions => ["role = 'Participant'"],:dependent => :destroy
  has_one :offerer, :class_name => 'UserServiceRole', :conditions => ["role = 'Offerer'"], :dependent => :destroy
  has_many :users, :through => :user_service_role
  has_many :images,:dependent => :destroy
  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories
  belongs_to :non_profit
  
  accepts_nested_attributes_for :images,:location, :allow_destroy => true
  
  validates :title,:description, :non_profit_id,:is_public, :presence => true
  validates :amount, :numericality => true, :presence => true
  validates :start_date,:end_date,:if => Proc.new { |t| t.is_scheduled == true}, :presence => true

end
