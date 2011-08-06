class Message < ActiveRecord::Base
  has_one  :sender, :class_name => 'UserMessageRole', :conditions => ["role = 'Sender'"], :dependent => :destroy
  has_one  :receiver, :class_name => 'UserMessageRole', :conditions => ["role = 'Receiver'"],:dependent => :destroy
  has_many :user_message_role, :dependent => :destroy
  has_many :users, :through => 'user_message_role'

  validates :title, :message, :presence => true
end
