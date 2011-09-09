require 'faker'
Factory.define :profile do |p|
  p.sequence(:first_name) {|n| "amit_first#{n}"}
  p.sequence(:last_name) {|n| "amit_last#{n}"}
  p.gender     "male"
  p.website    "google.com"
  p.about_me   "I M Fine"
end
