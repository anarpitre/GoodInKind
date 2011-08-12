class Service < ActiveRecord::Base
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :reviews
  has_many :user_service_role
  has_many :participants, :class_name => 'UserServiceRole', :conditions => ["role = 'Participant'"],:dependent => :destroy
  has_one  :offerer, :class_name => 'UserServiceRole', :conditions => ["role = 'Offerer'"], :dependent => :destroy
  has_many :users, :through => :user_service_role
  has_many :images,:dependent => :destroy
  has_many :resource_categories, :as => :resource, :dependent => :destroy
  has_many :categories, :through => :resource_categories #, :foreign_key => :category_id
  belongs_to :nonprofit
 
  accepts_nested_attributes_for :images, :location, :allow_destroy => true
  
  
  validates :title, :description, :presence => true
  validates_inclusion_of :is_public, :in => [true, false]
  validates :amount, :numericality => true, :presence => true
  validates :start_date, :end_date, :start_time, :end_time, :if => Proc.new { |t| t.is_schedulelater == false}, :presence => true
  validate :check_categories
  validate :check_date
  
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def check_categories
    errors.add_to_base("No category selected") if self.categories.blank?
  end

  def check_date
    unless self.is_schedulelater
        errors.add(:start_date,"Check Date") if self.start_date > self.end_date
        errors.add(:start_time," Check time") if self.start_time >= self.end_time
    end
  end

end
