Factory.define :profile do |p|
  p.first_name "Mehul"
  p.last_name  "Gurjar"
  p.gender     "male"
  p.age        "23"
  p.website    "http://www.google.com"
  p.about_me   "I M Fine"
  p.is_verified false
  p.avatar_file_name "Rails.gif"
  p.avatar_content_type "image/gif"
  p.avatar_file_size "2000"
#  p.user_id    User.first
end
