class Service < ActiveRecord::Base
  
  include AASM
  
  belongs_to  :user
  belongs_to :nonprofit 
  belongs_to :request
  has_one :location, :as => :resource,:dependent => :destroy
  has_many :reviews
  has_many :images,:dependent => :destroy
  
  has_many :service_categories, :dependent => :destroy
  has_many :categories, :through => :service_categories 
  has_many :bookings, :dependent => :destroy
 
  accepts_nested_attributes_for :images, :location, :allow_destroy => true
  
  
  validates :title, :description, :user_id, :nonprofit_id, :presence => true
  validates_inclusion_of :is_public, :in => [true, false]
  validates :amount, :numericality => true, :presence => true
  validates_inclusion_of :amount, :in => 5..9999, :message => " should be between $5 to $9999" 
  validates :start_date, :end_date, :if => Proc.new { |t| t.is_schedulelater == false}, :presence => true
  validate :check_categories
  validate :check_date
  validates_numericality_of :booking_capacity, :only_integer => true, :message => "can only be whole number."
  validates_numericality_of :estimated_duration, :only_integer => true, :message => "can only be whole number."
  
  scope :by_public, where(:is_public => true)
  
  after_create :generate_permalink

  after_save { |service|
    change_nonprofit = service.nonprofit_id_change
    if(change_nonprofit)
       if(change_nonprofit[0])
        nonprofit = Nonprofit.find(change_nonprofit[0]);
        nonprofit.categories.collect{|c| Category.decrement_counter(:service_count, c.id) }
       end
       if(change_nonprofit[1])
        nonprofit = Nonprofit.find(change_nonprofit[1]);
        nonprofit.categories.collect{|c| Category.increment_counter(:service_count, c.id) }
       end
    end
  }

  aasm_column :status
  aasm_initial_state :pending
  aasm_state :pending
  aasm_state :active, :enter => :verify_request

  aasm_event :activate do
    transitions :to => :active, :from => [ :pending, :active]
  end

  def verify_request
    self.request.offered! unless self.request.blank?
    add_index
  end

  def to_param
    self.permalink || "#{id}-#{title.parameterize}"
  end

  def check_categories
    errors.add(:category_ids, "No category selected") if self.categories.blank?
  end

  def check_date
    unless self.is_schedulelater
      errors.add(:start_date,"Check Date") unless (self.start_date.blank? || self.end_date.blank? || (self.start_date < self.end_date))
      errors.add(:start_time," Start time cannot be greater than End time") unless (self.start_time <= self.end_time)
    end
  end

  def as_json(options = {})
    options ||= {}
    options[:except] = [:description, :created_at, :updated_at]
    options[:methods] = [:to_param, :thumbnail]
    options[:include] = {:nonprofit => {:only => :name, :include => {:nonprofit_categories => {:only => :category_id}}},
      :service_categories => {:only => :category_id}}
    super
  end

  def thumbnail
    self.images.any? ? self.images.first.image.url(:thumb) : "/images/category/#{self.categories.first.image_path}_thumb.jpg"
  end

  def generate_permalink
    update_attribute(:permalink ,self.to_param)
  end

  def add_index
    INDEX.document("Service:id:#{self.id}").add({ :text => "#{self.title} #{self.description} #{self.user.profile.first_name} #{self.user.profile.last_name} #{categories.collect(&:name).to_s} #{nonprofit.categories.collect(&:name).to_s} #{nonprofit.name}"})
  end

end
