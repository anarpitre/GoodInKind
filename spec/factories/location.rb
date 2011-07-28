require 'faker'

Factory.define :service_location, :class => Location do |u|
  u.address 'baner'
  u.association :resource, :factory => 'service'
end

Factory.define :user_location, :class => Location do |u|
  u.address 'baner'
  u.association :resource, :factory => 'user'
end

Factory.define :non_profit_location, :class => Location do |np|
  np.address {Faker::Address.street_name}
  np.association :resource, :factory => 'non_profit'
end
