SERVICE = 1
NON_PROFIT = 2

FIRSTGIVING_CATETORIES = {
  "A" => "Arts, Culture & Humanities",
  "B" => "Education", 
  "C" => "Environment",
  "D" => "Animal-Related",
  "E" => "Health Care",
  "F" => "Mental Health & Crisis Intervention",
  "G" => "Voluntary Health Associations & Medical Disciplines",
  "H" => "Medical Research",
  "I" => "Crime & Legal-Related",
  "J" => "Employment",
  "K" => "Food, Agriculture, Nutrition",
  "L" => "Housing & Shelter",
  "M" => "Public Safety, Disaster Preparedness & Relief",
  "N" => "Recreation & Sports",
  "O" => "Youth Development",
  "P" => "Human Services",
  "Q" => "International, Foreign Affairs",
  "R" => "Civil Rights, Social Action & Advocacy",
  "S" => "Community Improvement & Capacity Building",
  "T" => "Philanthropy, Voluntarism & Grantmaking Foundations",
  "U" => "Science & Technology",
  "V" => "Social Science",
  "z" => "Public & Societal Benefit",
  "W" => "Religion-Related",
  "Y" => "Mutual & Membership Benefit",
  "Z" => "Unknown"
}

FIRSTGIVING_CATETORIES.each do |code, name|
  Category.create(:fg_code => code, :name => name, :category_type => NON_PROFIT)
end

SERVICE_CATEGORIES = [
"Arts and crafts", 
"Beauty and style", 
"Computer and Technology",
"Education and literature", 
"Family", 
"Food and drinks",
"Health and wellbeing", 
"History and Culture",
"Home and garden", 
"Money and career", 
"Nightlife",
"Recreation and outdoors",
"Sports",
"Tours"
]

SERVICE_CATEGORIES.each do |name|
  Category.create(:name => name, :category_type => SERVICE)
end

