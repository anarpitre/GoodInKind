require 'faker'
Factory.define :non_profit do |c|
  c.name {Faker::Name.name}
  c.EIN  "12345"
  c.description {Faker::Lorem.paragraph}
  c.photo_file_name "Rails.gif"
  c.photo_content_type "image/gif"
  c.photo_file_size "1000"
end

