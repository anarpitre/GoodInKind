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

  has_many :bookings, :dependent => :destroy  
  has_many :services, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_one  :profile, :dependent => :destroy
  has_one :cc_token, :dependent => :destroy # currently 1-1 mapping for CC token

  accepts_nested_attributes_for :profile, :allow_destroy => true
  
  after_create :generate_permalink
  
  scope :get_dummy_user, where("email = ?", DUMMY_EMAIL) 

  def to_param
    permalink || "#{id}-#{self.profile.first_name.parameterize}"
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    #Create user profile and profile location if provider is facebook
    if omniauth['provider'] == 'facebook'
      user_info = omniauth['user_info']
      unless omniauth[:extra].blank?
        user_hash = omniauth['extra']['user_hash'] 
        if user_hash.blank?
          gender = user_hash['gender']
          location = user_hash['location']['name']
        end
      end
      website = user_info['urls']['Facebook'] unless user_info['urls'].blank?
      self.build_profile(:first_name => user_info['first_name'], :last_name => user_info['last_name'], :facebook => website, :gender => gender )
      self.profile.build_location(:address => location) unless location.blank?
    end
    self.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    update_fb_image(omniauth['uid'])
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
  
  def update_fb_image(uid)
    filename = "/tmp/#{uid}.jpg"
    temp = File.open(filename, 'wb') do |f|
      f.write(FirstGiving.get("http://graph.facebook.com/#{uid}/picture?type=large", :format => :binary).body)
    end

    File.open(filename, 'rb') do |f|
      self.profile.avatar = f
    end

    self.save!

    File.unlink(filename)

    rescue Exception
      # Ignore all errors
  end

end
