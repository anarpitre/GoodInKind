require 'spec_helper'

describe ServicesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end
  context "User should be able to" do
    it "create a service with single category" do
      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      non_p.is_verified = "Verified"
      non_p.save
      post :create, :service => {:is_schedulelater => true, :start_date =>"", :end_time => "", :request_id =>"", :end_date => "", :start_time => "", :title => "service-create", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :location_attributes => {:address => "Ithaca"}, :is_public => true, :category_ids => ["#{cat[0]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("Service-create")
      ser.should_not == nil
    end

    it "create a service with multiple categories" do
      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      post :create, :nonprofit_name => non_p.name,
        :service => {:is_schedulelater => true, :title => "service-create-with-multiple-category", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("Service-create-with-multiple-category")
      ser.should_not == nil
    end

    it "create a service with same non-profit" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :create, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :title => "service-with-same-nonp", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => ser.nonprofit.id}
      ser1 = Service.find_by_title("Service-with-same-nonp")
      ser1.should_not == nil
      ser.nonprofit.name.should == ser1.nonprofit.name
    end

    it "update a service" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => { :title => "ser_update"},
        :id => ser.permalink
      ser_old = Service.find_by_title(ser.title)
      ser_old.should == nil
      ser_new = Service.find_by_title("Ser_update")
      ser_new.should_not == nil
    end

    it "delete a service"

    it "upload image" do
      file = File.open('spec/taj.jpg')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
        :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should_not == nil
      ser1.images.first.image_file_name.should == "taj.jpg"
    end

    it "uploaded logo is not in proper format e.g. txt" do
      file = File.open('spec/test.txt')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
        :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo is not in proper format e.g. pdf" do
      file = File.open('spec/test.pdf')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
        :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo is not in proper format e.g. word" do
      file = File.open('spec/test.doc')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
        :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo uploaded is more than 5 mb"
  end
end
