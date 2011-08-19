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
      post :create, :nonprofit_name => non_p.name,
                    :service => {:is_schedulelater => true, :title => "service-create", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("service-create")
      ser.should_not == nil
    end
    
    it "create a service with multiple categories" do
      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      post :create, :nonprofit_name => non_p.name,
                    :service => {:is_schedulelater => true, :title => "service-create-with-multiple-category", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("service-create-with-multiple-category")
      ser.should_not == nil
    end

    it "create a service with same non-profit" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :create, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :title => "service-with-same-nonp", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => ser.nonprofit.id}
      ser1 = Service.find_by_title("service-with-same-nonp")
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
      ser_new = Service.find_by_title("ser_update")
      ser_new.should_not == nil
    end

    it "delete a service"
  end
end
