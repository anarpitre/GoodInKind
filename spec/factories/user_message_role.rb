require 'faker'
Factory.define :usr_sender , :class => UserMessageRole do |u|
  u.role  'Sender'
  u.association :message, :factory => 'message'
  u.association :user, :factory => 'user'
end

Factory.define :usr_receiver, :class => UserMessageRole  do |u|
  u.role  'Receiver'
  u.association :message, :factory => 'message'
  u.association :user, :factory => 'user'
end

