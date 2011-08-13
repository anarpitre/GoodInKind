class Service < ActiveRecord::Base
  
  belongs_to  :user, :dependent => :destroy
  belongs_to :nonprofit
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :reviews
  has_many :users, :through => :user_service_role
  has_many :images,:dependent => :destroy
  has_many :resource_categories, :as => :resource, :dependent => :destroy
  has_many :categories, :through => :resource_categories #, :foreign_key => :category_id
 
  accepts_nested_attributes_for :images, :location, :allow_destroy => true
  
  
  validates :title, :description, :user_id, :presence => true
  validates_inclusion_of :is_public, :in => [true, false]
  validates :amount, :numericality => true, :presence => true
  validates :start_date, :end_date, :start_time, :end_time, :if => Proc.new { |t| t.is_schedulelater == false}, :presence => true
  validate :check_categories
  validate :check_date
  
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def check_categories
    errors.add(:base,"No category selected") if self.categories.blank?
  end

  def check_date
    unless self.is_schedulelater
        errors.add(:start_date,"Check Date") if self.start_date > self.end_date
        errors.add(:start_time," Check time") if self.start_time >= self.end_time
    end
  end

end
