require 'faker'
Factory.define :usr_participant , :class => UserServiceRole do |u|
  u.role  'Participant'
  u.association :service, :factory => 'service'
  u.association :user, :factory => 'user'
end

Factory.define :usr_offerer, :class => UserServiceRole  do |u|
  u.role  'Offerer'
  u.association :service, :factory => 'service'
  u.association :user, :factory => 'user'
end

