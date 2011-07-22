require 'faker'
Factory.define :service do |s|
  s.title { Faker::Name.name}
  s.description {Faker::Lorem.paragraph}
  s.amount '500'
  s.association :non_profit
  s.offerer_id '1'
  s.is_public true
  s.is_virtual true
  s.is_scheduled true
  s.non_profit_percentage '100'
  s.start_date Date.today
  s.end_date Date.today + 5.days
  s.association :location, :factory => 'service_location'
  #s.logo_file_name "Garden.jpg"
  #s.logo_content_type"image/jpeg"
  #s.logo_file_size "100100"
end
