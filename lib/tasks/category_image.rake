

   namespace :admin do 
     desc "create Category Image for Service"
     task :category_image => :environment do

       category = Category.find_by_name("Tours")
       unless category.blank?
        category.name = "Whacky"
        category.save!
       end
       
       category_image_hash = {
         "Arts and crafts" => "Arts_crafts.jpg",
         "Beauty and style" => "Beauty_style.jpg",
         "Computer and technology" => "Comp_tech.jpg", 
         "Education and literature" => "Education.jpg",
         "Family" => "Family.jpg",
         "Food and drinks" => "Food_drinks.jpg",
         "Health and wellbeing" => "Health_wellbeing.jpg", 
         "History and culture" => "culture.jpg", 
         "Home and garden" => "Home_garden.jpg",
         "Money and career" => "Career_money.jpg",
         "Nightlife" => "nightlife.jpg",
         "Recreation and outdoors" => "Recreation_outdoors.jpg", 
         "Sports" => "Sports.jpg", 
         "Whacky" => "Whacky.jpg"
       }
         
       category_image_hash.each {|k,v| 
         category = Category.where(:name => k)
         puts category[0].name
         category[0].image_path = v
         category[0].save!
       }
     end
   end

