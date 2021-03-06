
namespace :admin do 
  desc "create Service Suggestions"
  task :service_suggest => :environment do

  Suggestion.delete_all

    SERVICE_SUGGESTION = [
      "Learn Magic Tricks",
      "Vineyard tour",
      "French cooking classes",
      "Massage at the best spa in town",
      "Jewelry making",
      "Boat ride on the lake",
      "Jet skiing experience",
      "Story telling for children",
      "Best dog walker",
      "DJ for your next party",
      "Lead people on a hike",
      "Help stack firewood",
      "Tutor in Math",
      "Teach drumming",
      "Learn Guitar 101",
      "Learn to brew your own beer",
      "Custom tailor suit",
      "Bike repair",
      "Glam hairstyling",
      "Teach yoga",
      "Tie balloon animals at a party",
      "Learn to change your car oil",
      "Car washing",
      "Car detailing",
      "Moving help",
      "Experienced babysitting",
      "Pet-sitting",
      "Wash someone's dog",
      "Learn Salsa",
      "Learn West Coast swing dancing",
      "Design party invitations for someone",
      "Social media marketing help ",
      "Menu design for restaurant",
      "DSLR Photography lessons 101",
      "Professional Photoshoot",
      "Resume polishing",
      "Parenting advice",
      "Ideas for 20 whacky things to do",
      "Help someone paint their apartment",
      "Help build a kennel",
      "Build a doll house",
      "Jogging partner",
      "Gym trainer",
      "Learn tennis",
      "Learn golf from college coach",
      "Learn fly-fishing!",
      "Lawn mowing",
      "Rake someone's yard",
      "Help to shovel snow from driveway",
      "Teach calligraphy",
      "Show kids how to make paper airplanes",
      "Provide permaculture consulting services",
      "Career advice from a career coach",
      "Plant flowers in garden",
      "Website designing",
      "Clean garage",
      "Learn how to play bridge",
      "Play Poker like a pro!",
      "Advice for entrepreneurs",
      "Learn to juggle",
      "Learn Hebrew",
      "Teach Japanese",
      "Teach someone American Sign Language",
      "Alphabetize someones book or CD collection",
      "Organize someone's closet",
      "Pick the right wine for your evening",
      "Let someone vent at you after a bad day",
      "Italian wines 101",
      "Tour CNN headquarters",
      "Personal tour of downtown by a veteran local",
      "French cooking class",
      "Learn how to make Paella",
      "Real estate advice",
      "Home theatre experience for your family!",
      "Chai workshop",
      "Apple picking from local orchard",
      "Bungee jumping partner",
      "Origami 101",
      "Sushi and Sashimi making- the basics",
      "City wine bar tour"
    ]


    SERVICE_SUGGESTION.each do |name|
      Suggestion.create(:title => name)
    end

  end

end

