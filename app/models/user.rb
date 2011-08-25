class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable#, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes 
  
  has_many :reviews
  
  has_many :sent_messages, :class_name => 'Message', :foreign_key => :sender_id, :dependent => :destroy
  has_many :received_messages, :class_name => 'Message', :foreign_key => :receiver_id, :dependent => :destroy

  
  has_many :services, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_one  :location, :as => :resource, :dependent => :destroy
  has_one  :profile, :dependent => :destroy

  accepts_nested_attributes_for :profile, :allow_destroy => true
  
  after_create :generate_permalink
  
  scope :get_dummy_user, where("email = ?", DUMMY_EMAIL) 

  def to_param
    permalink || "#{id}-#{email.split('@').first.parameterize}"
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    if omniauth['provider'] == 'facebook'
      self.profile.first_name = omniauth['user_info']['first_name'] 
      self.profile.last_name = omniauth['user_info']['last_name'] 
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def confirmation_required?
    authentications.empty? && super
  end

  def generate_permalink
    update_attribute(:permalink ,self.to_param)
  end

end
