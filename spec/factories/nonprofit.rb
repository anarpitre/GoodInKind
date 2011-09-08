require 'faker'

Factory.define :nonprofit do |c|
  c.name {Faker::Name.name}
  c.contact_name {Faker::Name.name}
  c.position "Manager"
  c.sequence(:email) {|n| "amit#{n}@gg.com"}
  c.sequence(:username) {|a| "a123#{a}"}
  c.password "josh123"
  c.password_confirmation "josh123"
  c.sequence(:EIN) {|n| "12-123421#{n}"}
  c.website "www.test.com"
  c.is_active true
  c.guideline {Faker::Lorem.paragraph}
  c.description {Faker::Lorem.paragraph}
  c.phone_number "1-222-333-4444"
  c.cell_phone "1234567890"
  c.association :gateway_id, :factory => 'gateway'
  c.photo_file_name "Rails.gif"
  c.photo_content_type "image/gif"
  c.photo_file_size "1000"
end

