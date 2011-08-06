require 'faker'
Factory.define :review do |r|
  r.association :service_id, :factory => :service 
  r.association :user_id, :factory => :user
  r.group_number 1
  r.review {Faker::Lorem.paragraph}
  r.is_positive true
  r.is_active   true
end
