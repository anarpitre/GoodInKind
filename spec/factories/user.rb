require 'faker'
Factory.define :user do |u|
  u.sequence(:email)    {Faker::Internet.email}
  u.password 'josh123'
  u.is_admin true
  u.confirmed_at Time.now
  u.confirmation_sent_at Time.now
 # u.after_create {|a| Factory.create(:service)}
 # u.after_create {|a| Factory.create(:participant,:user_id => a.id)}

end

