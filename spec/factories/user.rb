require 'faker'
Factory.define :user do |u|
  u.sequence(:email)    {Faker::Internet.email}
  u.password 'josh123'
  u.is_admin 'false'
end

