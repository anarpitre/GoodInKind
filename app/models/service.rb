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
  
  
  validates :title, :description, :user_id, :presence => true
  validates_inclusion_of :is_public, :in => [true, false]
  validates_numericality_of :amount, :presence => true, :message => :service_amount
  validates_inclusion_of :amount, :in => 5..9999, :message => :service_amount_range
  validates :start_date, :end_date, :start_time, :end_time, :presence =>{:message => :not_valid, :if => Proc.new {|t| t.is_schedulelater == false}}
  validates_numericality_of :booking_capacity, :only_integer => true, :message => :booking_capacity
  validates_numericality_of :estimated_duration, :message => "Please enter a valid number"  
  validate :check_categories, :check_date, :check_nonprofit, :check_duration
  
  scope :by_public, where(:is_public => true)
  scope :by_user, lambda {|user_id| where(:user_id => user_id)}

  after_create :generate_permalink
  after_save :check_image

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
      start_date = self.start_date
      end_date = self.end_date
      start_time = self.start_time
      end_time = self.end_time
      unless (start_date.blank? && end_date.blank? )
        errors.add(:start_date,"Start date cannot be greater than End date") unless (start_date <= end_date)
        unless start_time.blank? && end_time.blank? 
          errors.add(:start_time," Start time cannot be greater than or equal to End time") if ((start_time >= end_time) && (start_date == end_date))
        end
      end
    end
  end

  def check_duration
    errors.add(:estimated_duration,"Duration must be in 0.5 hr increments") unless ((self.estimated_duration*10) % 5 == 0)
  end

  def check_nonprofit
    errors.add(:nonprofit_name, "Sorry! Could not find this non-profit with given name.Please click browse to choose your favorite non-profit") if self.nonprofit.blank?
  end

  def as_json(options = {})
    options ||= {}
    options[:except] = [:description, :created_at, :updated_at]
    options[:methods] = [:to_param, :thumbnail]
    options[:include] = {:nonprofit => {:only => :name, :include => {:nonprofit_categories => {:only => :category_id}}, :location => {:only => :address}},
      :service_categories => {:only => :category_id}}
    super
  end

  def thumbnail
    self.images.first ? self.images.first.image.url(:thumb) : "/images/category/cat_image_thumb.jpg"
  end

  def generate_permalink
    update_attribute(:permalink ,self.to_param)
  end

  def add_index
    INDEX.document("Service:id:#{self.id}").add({ :text => "#{self.title} #{self.description} #{self.user.profile.first_name} #{self.user.profile.last_name} #{categories.collect(&:name).to_s} #{nonprofit.categories.collect(&:name).to_s} #{nonprofit.name}"})
  end

  def check_image
    if self.images.blank?
      file = File.open("#{Rails.root}/public/images/category/#{self.categories.first.image_path}")
      self.update_attributes({:images_attributes => {"0" => { :image => file }}})
    end
  end

end
