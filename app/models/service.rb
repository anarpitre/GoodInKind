class Service < ActiveRecord::Base
  
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :participants
  has_many :users, :through => :participants
  has_many :images, :dependent => :destroy
  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories
  belongs_to :non_profit
  
  validates :title,:description, :offerer_id,:non_profit_id, :presence => true
  validates :amount, :numericality => true, :presence => true
  validates :start_date,:end_date,:if => Proc.new { |t| t.is_scheduled == true}, :presence => true

end
