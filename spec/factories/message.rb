require 'faker'
Factory.define :message do |m|
  m.title {Faker::Name.name}
  m.message {Faker::Lorem.paragraph}
  m.is_read false
  m.parent_message_id 0
end
