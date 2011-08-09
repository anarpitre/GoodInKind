require 'digest/sha1'

class NonProfit < ActiveRecord::Base

  EMAIL_REGEX = /^[a-z]+([+\.\w]+)*\w@[a-z0-9]+(\.\w+)+$/i
  has_many :non_profit_categories
  has_many :categories, :through => :non_profit_categories
  has_many :service_non_profit
  has_many :services, :through => :service_non_profit
  has_one :location, :as => :resource,:dependent => :destroy
  belongs_to :gateway

  validates :username, :presence => true,:uniqueness => true
  validates :EIN, :password, :password_confirmation, :contact_name, :name,  :presence => true
  validates_confirmation_of :password
  #validates :description, :uuid,  :presence => true
  validates :email,  :presence => true, :format => EMAIL_REGEX
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_size  :photo, :less_than => 2.megabytes

  has_attached_file :photo,
    :styles => { :thumb => [ "172x62#", :jpg ]} 

  #accepts_nested_attributes_for :location, :allow_destroy => true

  attr_accessor :password, :password_confirmation
  before_save :create_hash_password
  attr_protected :hashed_password, :salt

  def self.authenticate(username, password)
    non_profit_user = NonProfit.find_by_username(username)
    if non_profit_user && non_profit_user.password_match?(password)
      return non_profit_user
    else
      return false
    end
  end

  def password_match?(password)
    hashed_password == NonProfit.hash_with_salt(password, salt)
  end

  def self.make_salt(username)
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password, salt)
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end


  private

  def create_hash_password
    unless password.blank?
      self.salt = NonProfit.make_salt(username) if salt.blank?
      self.hashed_password = NonProfit.hash_with_salt(password,salt)
    end
  end
end
