require 'faker'
Factory.define :non_profit do |c|
  c.name {Faker::Name.name}
  c.contact_name {Faker::Name.name}
  c.email {Faker::Internet.free_email}
  c.username {Faker::Internet.user_name}
  c.password "josh123"
  c.uuid {Faker::Name.name}
  c.EIN  "12345"
  c.description {Faker::Lorem.paragraph}
  c.phone_number {Faker::PhoneNumber.phone_number}
  c.photo_file_name "Rails.gif"
  c.photo_content_type "image/gif"
  c.photo_file_size "1000"
end

