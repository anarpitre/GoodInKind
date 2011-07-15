Factory.define :service_location, :class => Location do |u|
  u.locality 'baner'
  u.city 'pune'
  u.state 'maharashra' 
  u.country 'India'
  u.association :resource, :factory => 'user'
end

Factory.define :user_location, :class => Location do |u|
  u.locality 'baner'
  u.city 'pune'
  u.state 'maharashra' 
  u.country 'India'
  u.association :resource, :factory => 'user'
end
