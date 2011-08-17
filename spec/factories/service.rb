require 'faker'

Factory.define :service do |s|
  s.sequence(:title) {Faker::Name.name}
  s.sequence(:description) {Faker::Lorem.paragraph}
  s.amount '500'
  s.booking_capacity 100
  s.is_public true
  s.is_virtual true
  s.is_schedulelater false 
  s.nonprofit_percentage '100'
  s.start_date Date.today
  s.end_date Date.today + 5.days
  s.start_time Time.now
  s.end_time Time.now + 5.minutes
  s.estimated_duration "10min"
  s.association :nonprofit_id, :factory => 'nonprofit'
  s.association :user_id, :factory => 'user'
end
