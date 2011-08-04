class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable#, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :user_service_role, :dependent => :destroy
  has_many :as_participants, :class_name => 'UserServiceRole', :conditions => ["role = 'Participant'"]
  has_many :as_offerer, :class_name => 'UserServiceRole', :conditions => ["role = 'Offerer'"]
  has_many :services, :through => :user_service_role
  has_many :authentications, :dependent => :destroy
  has_one :location, :as => :resource, :dependent => :destroy
  has_one :profile, :dependent => :destroy

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def confirmation_required?
    authentications.empty? && super
  end

end
