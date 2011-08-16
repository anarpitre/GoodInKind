require 'digest/sha1'

class Nonprofit < ActiveRecord::Base
  include AASM

  EMAIL_REGEX = /^[a-z]+([+\.\w]+)*\w@[a-z0-9]+(\.\w+)+$/i
  has_many :nonprofit_categories
  has_many :categories, :through => :nonprofit_categories

  has_many :service_nonprofits
  has_many :services, :through => :service_nonprofits

  has_one :location, :as => :resource,:dependent => :destroy
  belongs_to :gateway

  validates :username, :presence => true,:uniqueness => true
  validates :password, :password_confirmation, :contact_name, :name, :phone_number, :presence => true, :on => :create

  validates_confirmation_of :password, :on => :create
  validates :email,  :presence => true, :format => EMAIL_REGEX, :on => :create
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_size  :photo, :less_than => 2.megabytes

  has_attached_file :photo, S3_DEFAULTS.merge(
    :styles => { :thumb => [ "200x70#", :jpg] },
    :default_url => "/images/missing/nonprofit_ph.jpg"
  )

  scope :verified, where(:is_verified => 'yes')

  accepts_nested_attributes_for :location, :allow_destroy => true

  attr_accessor :password, :password_confirmation
  attr_protected :hashed_password, :salt

  before_create :create_hash_password
  after_create :generate_permalink

  ###  AASM transition ###
  aasm_column :is_verified
  aasm_initial_state :no

  aasm_state :no
  aasm_state :yes, :enter => :confirm_nonprofit
  aasm_state :rejected, :enter => :reject_nonprofit

  aasm_event :confirm! do
    transitions :to => [:yes, :rejected], :from => :no
  end

  aasm_event :reject! do
    transitions :to => :rejected, :from => [:yes, :no]
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

  private

  def self.make_salt(username)
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password, salt)
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
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
end
