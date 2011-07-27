class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :user_service_role
  has_many :as_participants, :class_name => 'UserServiceRole', :conditions => ["role = 'Participant'"],:dependent => :destroy
  has_many :as_offerer, :class_name => 'UserServiceRole', :conditions => ["role = 'Offerer'"], :dependent => :destroy
  has_many :services, :through => :user_service_role
  has_one :location, :as => :resource,:dependent => :destroy
  has_one :profile, :dependent => :destroy


end
