require 'faker'

namespace :admin do 
  desc "create Fake Service"
  task :fake_service => :environment do

    service_cat = Category.where(:category_type => 1)
    nonprofit_cat = Category.where(:category_type => 2)

    user = User.create(:email => Faker::Internet.free_email, :password => "josh123", :confirmed_at =>  Time.now)
    user.confirmed_at = Time.now
    user.save

    profile = user.build_profile
    profile.save(false)

    nonprofits = []

    20.times do
      nonprofit = Nonprofit.new(:name => Faker::Name.name, 
                                :contact_name => Faker::Name.name, 
                                :email => Faker::Internet.free_email, 
                                :username => Faker::Internet.user_name,
                                :password => "josh123",
                                :password_confirmation => "josh123",
                                :phone_number => 1234567890 
                                )
      nonprofit.categories << nonprofit_cat.rand
      nonprofit.save!
      nonprofits << nonprofit
    end

    100.times do

      start_date = Date.today - rand(30)
      end_date = start_date + rand(15)

      service = Service.new(:title => Faker::Name.name, 
                            :description => Faker::Lorem.paragraph,
                            :amount => rand(600),
                            :start_date => start_date,
                            :end_date => end_date,
                            :nonprofit_id => nonprofits.rand.id,
                            :user_id => user.id)

      service.categories << service_cat.rand
      service.save!

    end
  end

  # TODO: Remove duplication. Call this task before fake_service
  desc "create Fake Nonprofits"
  task :fake_nonprofits => :environment do
    nonprofit_cat = Category.where(:category_type => 2)
    100.times do
      nonprofit = Nonprofit.new(:name => Faker::Name.name, 
                                :EIN => rand(9999999),
                                :position => Faker::Name.name,
                                :website => Faker::Internet.domain_name,
                                :contact_name => Faker::Name.name, 
                                :email => Faker::Internet.free_email, 
                                :username => Faker::Internet.user_name,
                                :description => Faker::Lorem.paragraph,
                                :uuid => SecureRandom.hex,
                                :password => "josh123",
                                :password_confirmation => "josh123",
                                :phone_number => 1234567890 
                                )
      nonprofit.categories << nonprofit_cat.rand
      nonprofit.save!
    end
  end

end

