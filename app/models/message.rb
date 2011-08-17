class Message < ActiveRecord::Base
  
  belongs_to :sender, :class_name => 'User', :dependent => :destroy
  belongs_to :receiver, :class_name => 'User', :dependent => :destroy

  validates :title, :message, :presence => true
  validate :check_receiver
  
  scope :get_unread_message, lambda{ |user_id| where("is_read = ? and receiver_id = ?", false, user_id).order('created_at DESC') }
  scope :get_read_message, lambda{ |user_id| where("is_read = ? and receiver_id = ?", true, user_id).order('created_at DESC') }

  def check_receiver
    errors.add(:receiver_id,"User doesnot exist") if self.receiver.blank?
  end

end
