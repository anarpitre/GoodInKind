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
      post :create, :service => {:is_schedulelater => true, :qualification => "BE IT", :start_date =>"", :end_time => "", :request_id =>"", :end_date => "", :start_time => "", :title => "service-create", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :location_attributes => {:address => "Ithaca"}, :is_public => true, :category_ids => ["#{cat[0]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("Service-create")
      ser.should_not == nil
      response.should redirect_to("http://test.host/services/thankyou") 
    end

    it "create a service with multiple categories" do
      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      post :create, :nonprofit_name => non_p.name,
        :service => {:is_schedulelater => true, :title => "service-create-with-multiple-category", :qualification => "Be IT", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("Service-create-with-multiple-category")
      ser.should_not == nil
    end

    it "create a service with same non-profit" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :create, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :title => "service-with-same-nonp", :qualification => "BE IT", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => ser.nonprofit.id}
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
      ser_new = Service.find_by_title("ser_update")
      ser_new.should_not == nil
    end

    it "delete a service" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      get :remove, :id => ser.permalink
      ser_old = Service.find_by_title(ser.title)
      p ser_old
      ser_old.status.should == "removed"

    end

    it "upload image" do
      file = File.open('spec/taj.jpg')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
        :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
        :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      p ser1
      p ser1.images
      ser1.should_not == nil
      ser1.images.should_not == nil
      ser1.images.second.image_file_name.should == "taj.jpg"
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
      ser1.images.first.image_file_name.should_not == "test.txt"
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
      ser1.images.first.image_file_name.should_not == "test.pdf"
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
      ser1.images.first.image_file_name.should_not == "test.doc"
    end

    it "uploaded logo uploaded is more than 5 mb"
  end
end

describe ServicesController do
  context "Service status : Active , Login user should be able to access" do
    before(:each) do
      @ser = Factory(:service)
      @ser.status.should == "active"
      @ser.save
      @user = @ser.user
      @request.env['devise.mapping'] = :user
      sign_in @user
    end
    it "service detail page" do
      get :service_detail, :id => @ser.permalink
      flash[:notice].should_not == "Service does not exist"
    end

    it "offer again page" do
      get :offer_again, :id => @ser.permalink
      flash[:notice].should_not == "Service does not exist"
    end

    it "edit service page" do
      get :edit, :id => @ser.permalink
      flash[:notice].should_not == "Service does not exist"
    end

    it "view service page" do
      get :show, :id => @ser.permalink
      flash[:notice].should_not == "Service does not exist"
    end
  end

  context "Service status : Active ,Non- Login user" do
    before(:each) do
      @service = Factory(:service)
      @service.status.should == "active"
      @service.save
      p @service
      @user = @service.user
    end
    it "should be able to access service detail page" do
      get :service_detail, :id => @service.permalink
      response.should redirect_to("http://test.host/users/sign_in")
    end

    it "should not be able to access offer again page" do
      get :offer_again, :id => @service.permalink
      flash[:notice].should == "You do not have sufficent privileges."
      response.should redirect_to("http://test.host/services/#{@service.permalink}")
    end

    it "should not be able to edit service page" do
      get :edit, :id => @service.permalink
      response.should redirect_to("http://test.host/users/sign_in") 
    end

    it "should be able to view service page" do
      get :show, :id => @service.permalink
      response.should be_success
      flash[:notice].should_not == "You need to sign in or sign up before continuing."
      flash[:notice].should_not == "Service does not exist"
      flash[:notice].should_not == "You do not have sufficent privileges."
    end
  end

  context "Service status : Expired/Removed , Login user" do
    before(:each) do
      @service = Factory(:service)
      @service.status = "removed"
      @service.save
      p @service
      @user = @service.user
      @request.env['devise.mapping'] = :user
      sign_in @user
    end
    it "should be able to access service detail page" do
      get :service_detail, :id => @service.permalink
      response.should be_success
      flash[:notice].should_not == "You need to sign in or sign up before continuing."
      flash[:notice].should_not == "Service does not exist"
      flash[:notice].should_not == "You do not have sufficent privileges."
    end

    it "should be able to access offer again page" do
      get :offer_again, :id => @service.permalink
      response.should be_success
      flash[:notice].should_not == "You need to sign in or sign up before continuing."
      flash[:notice].should_not == "Service does not exist"
    end

    it "should not able to edit service page" do
      get :edit, :id => @service.permalink
      response.should redirect_to("http://test.host/") 
      flash[:notice].should == "This service has been removed or has expired"
    end

    it "should not able to view service page" do
      get :show, :id => @service.permalink
      response.should redirect_to("http://test.host/") 
      flash[:notice].should == "This service has been removed or has expired"
    end
  end

  context "Service status : Active ,Non- Login user" do
    before(:each) do
      @service = Factory(:service)
      @service.status.should == "active"
      @service.save
      p @service
      @user = @service.user
    end
    it "should not be able to access service detail page" do
      get :service_detail, :id => @service.permalink
      response.should redirect_to("http://test.host/users/sign_in") 
    end

    it "should not be able to access offer again page" do
      get :offer_again, :id => @service.permalink
      response.should redirect_to("http://test.host/services/#{@service.permalink}") 
      flash[:notice].should == "You do not have sufficent privileges."
    end

    it "should not be able to edit service page" do
      get :edit, :id => @service.permalink
      response.should redirect_to("http://test.host/users/sign_in") 
    end

    it "should not be able to view service page" do
      get :show, :id => @service.permalink
      response.should be_success
    end
  end
end
