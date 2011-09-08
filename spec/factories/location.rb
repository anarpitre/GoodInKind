require 'faker'

Factory.define :service_location, :class => Location do |u|
  u.address 'Ithaca'
  u.association :resource, :factory => 'service'
end

Factory.define :user_location, :class => Location do |u|
  u.address 'Ithaca'
  u.association :resource, :factory => 'user'
end

Factory.define :nonprofit_location, :class => Location do |np|
  np.address 'Ithaca'
  np.association :resource, :factory => 'nonprofit'
end

Factory.define :request_location, :class => Location do |np|
  np.address 'Ithaca'
  np.association :resource, :factory => 'request'
end
