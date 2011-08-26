require 'digest/sha1'

class Nonprofit < ActiveRecord::Base
  include AASM

  has_many :nonprofit_categories
  has_many :categories, :through => :nonprofit_categories

  has_many :services

  has_one :location, :as => :resource, :dependent => :destroy
  belongs_to :gateway

  validates_length_of :description, :maximum => 300
  validates_length_of :guideline, :maximum => 75
  validates :username, :presence => true, :uniqueness => true
  validates :password, :password_confirmation, :presence => true, :on => :create
  validates :contact_name, :name, :phone_number, :EIN, :website, :photo_file_name, :position, :presence => true

  validates_confirmation_of :password, :on => :create
  validates :email,  :presence => true, :format => EMAIL_REGEX
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif", "image/jpg", "image/bmp", "image/tiff", "image/tif" ]
  validates_attachment_size  :photo, :less_than => 2.megabytes

  has_attached_file :photo, S3_DEFAULTS.merge(
    :styles => { 
      :thumb => "172x62!", 
      :medium => "200x61!"
    },
    :default_url => "/images/missing/nonprofit_:style.jpg"
  )

  accepts_nested_attributes_for :location, :allow_destroy => true

  attr_accessor :password, :password_confirmation
  attr_protected :hashed_password, :salt

  before_create :create_hash_password
  after_create :generate_permalink, :send_invitation
  after_create :add_index

  ###  AASM transition ###
  aasm_column :is_verified
  aasm_initial_state :created

  aasm_state :created
  aasm_state :verified, :enter => :confirm_nonprofit
  aasm_state :rejected, :enter => :reject_nonprofit

  aasm_event :confirm! do
    transitions :to => :verified, :from => [:created, :rejected]
  end

  aasm_event :reject! do
    transitions :to => :rejected, :from => [:verified, :created]
  end
  
  def to_param
    permalink || "#{id}-#{name.parameterize}"
  end

  def confirm_nonprofit
    # FIXME: Deliver confirmation email notification
  end

  def reject_nonprofit
    # FIXME: Deliver rejection email notification
  end

  def self.authenticate(username, password)
    nonprofit_user = Nonprofit.find_by_username(username)
    if nonprofit_user && nonprofit_user.password_match?(password)
      return nonprofit_user
    else
      return false
    end
  end

  def password_match?(password)
    hashed_password == Nonprofit.hash_with_salt(password, salt)
  end

  # Set password and password confirmation to nil
  def clean_up_passwords
    self.password = self.password_confirmation = ""
  end
  
  private

  def self.make_salt(username)
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password, salt)
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  def update_password(new_password)
    self.password = new_password
    create_hash_password
    update_attribute(:salt, self.salt)
    update_attribute(:hashed_password, self.hashed_password)
  end

  def create_hash_password
    unless password.blank?
      self.salt = Nonprofit.make_salt(username) if salt.blank?
      self.hashed_password = Nonprofit.hash_with_salt(password,salt)
    end
  end

  def generate_permalink
    update_attribute(:permalink ,self.to_param)
  end

  def send_invitation
    Notifier.nonprofit_invitation(self.email, self.contact_name).deliver
  end
  
  def add_index
    INDEX.document("Nonprofit:id:#{self.id}").add({ :text => "#{self.categories.collect(&:name).to_s} #{self.name} #{self.description}"})
  end


end
