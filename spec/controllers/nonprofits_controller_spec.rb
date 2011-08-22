require 'spec_helper'

describe NonprofitsController do
  before(:each) do
    @non_pro = Factory(:nonprofit)
  end
  context "Nonprofit should be" do
    it "created if all the attributes are valid with Post request and initial status should be Created" do
      post :create, :nonprofit => {:name => "cry", :EIN => "123456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "cry123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "12345678", :cell_phone => "1234567890"}
      non_pro = Nonprofit.find_by_name("cry")
      non_pro.should_not == nil
      non_pro.is_verified.should == "created"
    end

    it "update his guildeline and mission fields only if the status of nonprofit is verified"


    it "update his name and other profile fields only if the status of nonprofit is verified"

    it "update his password"
  end
  context "Nonprofit should not be" do
    it "update anyting if status is created" 
  end

end
