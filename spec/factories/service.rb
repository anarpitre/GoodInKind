Factory.define :service do |s|
  s.title 'Karate class'
  s.description  'Karate class'
  s.amount '500'
  s.charity_id '1'
  s.priority 'true'
  s.is_scheduled 'true'
  s.charity_float '100'
  s.start_time Time.now
  s.end_time Time.now+10.hours
  s.start_date Date.today
  s.end_date Date.today + 5.days
  #s.logo_file_name "Garden.jpg"
  #s.logo_content_type"image/jpeg"
  #s.logo_file_size "100100"
end
