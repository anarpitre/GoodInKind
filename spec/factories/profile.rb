Factory.define :profile do |p|
  p.first_name "Mehul"
  p.last_name  "Gurjar"
  p.gender     "male"
  p.age        "23"
  p.website    "http://www.google.com"
  p.about_me   "I M Fine"
  p.is_verified false
#  p.user_id    User.first
end
