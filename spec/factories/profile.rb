require 'faker'
Factory.define :profile do |p|
  p.sequence(:first_name)  {Faker::Name.name}
  p.sequence(:last_name)  {Faker::Name.name}
  p.gender     "male"
  p.age        "23"
  p.sequence(:website)    {Faker::Internet.email}
  p.about_me   "I M Fine"
  p.is_verified false
  p.avatar_file_name "Rails.gif"
  p.avatar_content_type "image/gif"
  p.avatar_file_size "2000"
  p.association :user
end
