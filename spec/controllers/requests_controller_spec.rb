require 'spec_helper'

describe RequestsController do
  context "Service request should be created by non logged in users if" do
    it "all the attributes are provided" do
      post :create, :request => {:title => "test-service-controller", :description => "Testing controller action for crrating request", :email => "testser@ser.com",
                                :location_attributes => {:address => "nashik"}}
      req = Request.find_by_email("testser@ser.com")
      req.should_not == nil
      req.location.should_not == nil
    end
    
    it "all the attributes are provided except address" do
      post :create, :request => {:title => "test-service-controller", :description => "Testing controller action for crrating request", :email => "testser@ser.com",
                                :location_attributes => {:address => ""}}
      req = Request.find_by_email("testser@ser.com")
      req.should_not == nil
      req.location.should == nil
    end
  end

  context "Service request should be created by logged in users if" do
    before(:each) do
      @user = Factory(:user)
      @request.env['devise.mapping'] = :user
      sign_in @user
    end
    it "all the attributes are provided" do

      post :create, :request => {:title => "test-service-controller", :description => "Testing controller action for crrating request", :email => "testser@ser.com",
        :location_attributes => {:address => "nashik"}}
      req = Request.find_by_email("testser@ser.com")
      req.should_not == nil
      req.location.should_not == nil
    end

    it "all the attributes are provided except address" do
      post :create, :request => {:title => "test-service-controller", :description => "Testing controller action for crrating request", :email => "testser@ser.com",
        :location_attributes => {:address => ""}}
      req = Request.find_by_email("testser@ser.com")
      req.should_not == nil
      req.location.should == nil
    end
  end
end
