require 'faker'

namespace :admin do 
  desc "create Fake Service"
  task :fake_service => :environment do

    service_cat = Category.where(:category_type => 1).collect(&:id)
    nonprofit_cat = Category.where(:category_type => 2).collect(&:id) 


    2.times do

    user = User.create(:email => Faker::Internet.free_email, :password => "josh123", :confirmed_at =>  Time.now)

    nonprofit = Nonprofit.create(:name => Faker::Name.name, :contact_name => Faker::Name.name, :email => Faker::Internet.free_email, :username => Faker::Internet.user_name, :password => "josh123", :password_confirmation => "josh123", :phone_number => 1234567890, :mission_statement => Faker::Name.name, :category_id => "#{nonprofit_cat.rand()}")

    service = Service.new(:title => Faker::Name.name, :description => Faker::Lorem.paragraph, :amount => rand(600), :start_date => Date.today-rand(30),:end_date => Date.today.next-rand(30) , :nonprofit_id => nonprofit.id , :user_id => user.id )

    service.service_categories.build(:category_id => "#{service_cat.rand()}")
    service.save

    end
  end
end

