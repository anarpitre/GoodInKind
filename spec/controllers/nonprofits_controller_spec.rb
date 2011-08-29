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

    it "created if photo is uploaded along with other attributes" do
      file = File.open('spec/taj.jpg')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "123456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "cry123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "12345678", :cell_phone => "1234567890"}
      non_pro = Nonprofit.find_by_name("cry")
      p non_pro
      non_pro.should_not == nil
      non_pro.is_verified.should == "created"
      non_pro.photo_file_name.should == "taj.jpg"
    end

    it "update his guildeline and mission fields only if the status of nonprofit is verified"


    it "update his name and other profile fields only if the status of nonprofit is verified"

    it "update his password" do
      @non_pro.reset_password_token = ActiveSupport::SecureRandom.hex(10)
      @non_pro.save
      post :update_password, :nonprofit =>{ :password_confirmation => "test123", :reset_password_token => @non_pro.reset_password_token, :password => "test123"}
      flash[:notice].should == "Your password was changed successfully."
    end

    it "able to get change password instructions by clicking on forgot password link" do
      post :forgot_password, :nonprofit => {:username => @non_pro.username}
      flash[:notice].should == "Instructions to change your password have been sent to the email address on your profil"
    end

    it "able to get his username by clicking on forgot username link" do
      post :forgot_username, :nonprofit => {:ein => @non_pro.EIN}
      flash[:notice].should == "Email was sent successfully"
    end

  end
  context "Nonprofit should not be" do
    it "created if photo is uploaded along with other attributes" do
      file = File.open('spec/4mb.JPG')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "123456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "cry123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "12345678", :cell_phone => "1234567890"}
      non_pro = Nonprofit.find_by_name("cry")
      non_pro.should == nil
    end

    it "update anyting if status is created" 

    it "if uploaded photo is not in proper format e.g. txt"
    it "if uploaded photo is not in proper format e.g. pdf"
    it "if uploaded photo is not in proper format e.g. word"
  end

end
