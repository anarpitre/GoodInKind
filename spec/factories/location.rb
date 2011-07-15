require 'faker'
Factory.define :location do |u|
  u.locality {Faker::Address.street_name}
  u.city {Faker::Address.city}
  u.state {Faker::Address.us_state} 
  u.country 'US' 
  u.resource_type 'user'
  u.resource_id '1'
end
