require 'faker'
Factory.define :service do |s|
  s.title { Faker::Name.name}
  s.description {Faker::Lorem.paragraph}
  s.amount '500'
  s.is_public true
  s.is_virtual true
  s.is_scheduled true
  s.non_profit_percentage '100'
  s.start_date Date.today
  s.end_date Date.today + 5.days
  s.start_time Time.now
  s.end_time Time.now + 5.minutes
  s.association :non_profit_id, :factory => 'non_profit'
end
