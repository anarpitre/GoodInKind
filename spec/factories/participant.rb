Factory.define :participant do |p|
  p.association :user
  p.association :service
end

