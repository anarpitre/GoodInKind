class Service < ActiveRecord::Base
  
  include AASM
  
  belongs_to  :user, :dependent => :destroy
  belongs_to :nonprofit
  belongs_to :request
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :reviews
  has_many :images,:dependent => :destroy
  
  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories 
 
  accepts_nested_attributes_for :images, :location, :allow_destroy => true
  
  
  validates :title, :description, :user_id, :nonprofit_id, :presence => true
  validates_inclusion_of :is_public, :in => [true, false]
  validates :amount, :numericality => true, :presence => true
  validates :start_date, :end_date, :start_time, :end_time, :if => Proc.new { |t| t.is_schedulelater == false}, :presence => true
  validate :check_categories
  validate :check_date
  
  after_create :generate_permalink

  aasm_column :status
  aasm_initial_state :pending
  aasm_state :pending
  aasm_state :active, :enter => :verify_request

  aasm_event :activate do
    transitions :to => :active, :from => [ :pending, :active]
  end

  def verify_request
    self.request.offered! unless self.request.blank?
  end

  def to_param
    permalink || "#{id}-#{title.parameterize}"
  end

  def check_categories
    errors.add(:base,"No category selected") if self.categories.blank?
  end

  def check_date
    unless self.is_schedulelater
      errors.add(:start_date,"Check Date") unless (self.start_date || self.end_date || (self.start_date < self.end_date))
      errors.add(:start_time," Check time") unless (self.start_time || self.end_time || (self.start_time <= self.end_time))
    end
  end


  def generate_permalink
    update_attribute(:permalink ,self.to_param)
  end

end
