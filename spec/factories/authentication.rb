
Factory.define :authentication, :class => Authentication do |u|
  u.provider 'facebook'
  u.uid '11111111111111111111'
  u.association :user_id, :factory => 'user'
end
