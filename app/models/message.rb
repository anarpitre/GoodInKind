class Message < ActiveRecord::Base
  
  belongs_to :sender, :class_name => 'User', :dependent => :destroy
  belongs_to :receiver, :class_name => 'User', :dependent => :destroy

  validates :title, :message, :presence => true
  validate :check_receiver

  def check_receiver
    errors.add(:receiver_id,"User doesnot exist") if self.receiver.blank?
  end
end
