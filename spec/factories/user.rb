require 'faker'

Factory.define :user do |u|
  u.sequence(:email) {Faker::Internet.free_email}
  u.password 'josh123'
  u.is_admin false
  u.confirmed_at Time.now
  u.confirmation_sent_at Time.now
  u.association :profile
end

Factory.define :admin_user, :class => User do |u|
  u.sequence(:email) {Faker::Internet.free_email}
  u.password 'josh123'
  u.is_admin true
  u.confirmed_at Time.now
  u.confirmation_sent_at Time.now
end

