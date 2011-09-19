require 'faker'
Factory.define :service do |s|
 # s.sequence(:title) {|n| "ser_title#{n}"}
  s.title "service_title"
  s.sequence(:description) {|n| "ser_description#{n}"}
  s.qualification "BE I.T"
  s.amount 500
  s.booking_capacity 100
  s.booked_seats 0
  s.status "active"
  s.is_public true
  s.is_virtual true
  s.is_schedulelater false 
  s.start_date Date.today
  s.end_date Date.today + 5.days
  s.start_time Time.now
  s.end_time Time.now + 5.minutes
  s.estimated_duration 5
  s.categories { |a| [a.association(:s_category)]}
  s.association :nonprofit, :factory => 'nonprofit'
  s.association :user, :factory => 'user'
end
