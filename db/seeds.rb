# NonProfits Categories +++++++++++++++++++++
a = ["A", "B", "C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","z","W", "Y" ,"Z"] 
 b = [ "Arts, Culture & Humanities" ,"Education" ,"Environment", "Animal-Related" ," Health Care","Mental Health & Crisis Intervention" ,"Voluntary Health Associations & Medical Disciplines" ,"Medical Research" ," Crime & Legal-Related" ,"Employment" ,"Food, Agriculture, Nutrition" ,"Housing & Shelter" ,"Public Safety, Disaster Preparedness & Relief" ,"Recreation & Sports" ,"Youth Development","Human Services","International, Foreign Affairs" ,"Civil Rights, Social Action & Advocacy" ,"Community Improvement & Capacity Building" ,"Philanthropy, Voluntarism & Grantmaking Foundations","Science & Technology","Social Science","Public & Societal Benefit","Religion-Related", "Mutual & Membership Benefit" ,"Unknown"]
 x ={}
 c= 0

26.times do
     cat = Category.new
     cat.category_type = 2
   cat.fg_code = a[c]
   cat.name = b[c]
   x[cat.fg_code] = b[c]
   c = c + 1
   cat.save
end
#++++++++++++++++++++++++

# Service Categories

category = ["Arts and crafts", "Beauty and style", "Computer and Technology", "Education and literature", "Family", "Food and drinks", "Health and wellbeing", "History and Culture", "Home and garden", "Money and career", "Nightlife", "Recreation and outdoors", "Sports", "Tours"] 
category.each do |cat|
  a = Category.new
  a.name = cat
  a.category_type = 1
  a.save
end
