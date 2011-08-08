SERVICE = 1
NON_PROFIT = 2

FIRSTGIVING_CATETORIES => {
  "A" => "Arts, Culture & Humanities",
  "B" => "Education", 
  "C" => "Environment",
  "D" => "Animal-Related",
  "E" => "Health Care",
  "F" => "Mental Health & Crisis Intervention",
}

FIRSTGIVING_CATETORIES.each do |code, name|
  Category.create(:fg_code => code, :name => name, :category_type => NON_PROFIT)
end

SERVICE_CATEGORIES = [
"Arts and crafts", 
"Beauty and style", 
"Computer and Technology",
"Education and literature", "Family", "Food and drinks", "Health and wellbeing", "History and Culture", "Home and garden", "Money and career", "Nightlife", "Recreation and outdoors", "Sports", "Tours"]

SERVICE_CATEGORIES.each do
  Category.create(:name => name, :category_type => SERVICE)
end

