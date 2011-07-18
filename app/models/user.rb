class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


 #has_many :participants, :class_name => 'Role', :conditions => ["role = 'Participant'"],:dependent => :destroy
 #has_many :offers, :class_name => 'Role', :conditions => ["role = 'Offer'"], :dependent => :destroy

 has_many :participants
 has_many :services, :through => :participants
 has_one :location, :as => :resource,:dependent => :destroy
 has_one :profile, :dependent => :destroy


end
