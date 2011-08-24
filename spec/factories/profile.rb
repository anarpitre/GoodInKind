require 'faker'
Factory.define :profile do |p|
  p.sequence(:first_name)  {Faker::Name.name}
  p.sequence(:last_name)  {Faker::Name.name}
  p.gender     "male"
  p.website    {Faker::Internet.email}
  p.about_me   "I M Fine"
  p.is_verified false
end
