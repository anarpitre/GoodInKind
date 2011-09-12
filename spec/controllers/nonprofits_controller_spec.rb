require 'spec_helper'

describe NonprofitsController do
  before(:each) do
    @non_pro = Factory(:nonprofit)
  end
  context "Nonprofit should be" do
    it "created if all the attributes are valid with Post request and initial status should be Created" do
      file = File.open('spec/taj.jpg')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "12-1223456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "cry123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "123-456-1178", :cell_phone => "123-456-7890"}
      non_pro = Nonprofit.find_by_name("cry")
      non_pro.should_not == nil
      non_pro.is_verified.should == "Pending"
    end

    it "created if photo is uploaded along with other attributes" do
      file = File.open('spec/taj.jpg')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "12-1213456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "cry123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "123-456-7118", :cell_phone => "123-456-7890"}
      non_pro = Nonprofit.find_by_name("cry")
      p non_pro
      non_pro.should_not == nil
      non_pro.is_verified.should == "Pending"
      non_pro.photo_file_name.should == "taj.jpg"
    end
=begin
    it "update his guildeline and mission fields only if the status of nonprofit is verified" do
      login_as @non_pro
      p @non_pro.permalink
      post :update, :id => @non_pro.permalink, :nonprofit =>{ :name => "non512", :location_attributes => {:address => "Pune", :id => "14"}, :category_ids => "14", :website => "www.qwwqq.com", :guideline => "testing", :description => "test"}
     # post :update, :id=> @non_pro.permalink, 
      #              :nonprofit => { :guideline => "This is testing guideline", :description => "This is testing description"}
      non_pro = Nonprofit.find(@non_pro)
      non_pro.guideline.should == "This is testing guideline"
    end
=end
    it "update his name and other profile fields only if the status of nonprofit is verified"

    it "update his password" do
      @non_pro.reset_password_token = ActiveSupport::SecureRandom.hex(10)
      @non_pro.save
      post :update_password, :nonprofit =>{ :password_confirmation => "test123", :reset_password_token => @non_pro.reset_password_token, :password => "test123"}
      flash[:notice].should == "Your password was changed successfully."
    end
    
    it "created if password and confirm password is short i.e. a" do
      file = File.open('spec/taj.jpg')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "12-1223456", :website => "www.cry.com", :username => "non-cry", :password => "123", :password_confirmation => "123", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "123-456-1178", :cell_phone => "123-456-7890"}
      non_pro = Nonprofit.find_by_name("cry")
      non_pro.should_not == nil
    end

    it "able to get change password instructions by clicking on forgot password link" do
      post :forgot_password, :nonprofit => {:username => @non_pro.username}
      flash[:notice].should == "Instructions to change your password have been sent to the email address on your profile"
    end

    it "able to get his username by clicking on forgot username link" do
      post :forgot_username, :nonprofit => {:EIN => @non_pro.EIN}
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

    it "created if password and confirm password does not match" do
      file = File.open('spec/taj.jpg')
      post :create, :nonprofit => {:name => "cry", :photo => file, :EIN => "12-1223456", :website => "www.cry.com", :username => "non-cry", :password => "cry123", :password_confirmation => "123cry", :contact_name => "cry-user", :position => "manager", :email => "user@yser.com", :phone_number => "123-456-1178", :cell_phone => "123-456-7890"}
      non_pro = Nonprofit.find_by_name("cry")
      non_pro.should == nil
    end
    
    
    it "update anyting if status is created" 

    it "if uploaded photo is not in proper format e.g. txt"
    it "if uploaded photo is not in proper format e.g. pdf"
    it "if uploaded photo is not in proper format e.g. word"
  end
end
