require 'faker'
Factory.define :message do |m|
  m.title "test message"
  m.message "test description"
  m.is_read false
  m.parent_message_id 0
  m.association :receiver, :factory => :user
  m.association :sender, :factory => :user
end
