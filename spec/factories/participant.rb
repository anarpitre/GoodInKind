Factory.define :participant do |p|
  p.association :service
  p.association :user
end

