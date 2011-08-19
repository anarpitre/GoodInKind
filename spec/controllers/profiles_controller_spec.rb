require 'spec_helper'

describe ProfilesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end

  context "User profile should be updated" do
    it "by post request" do
      post :update, :profile => {:about_me => "This is controller testing of profile", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                    :id => @user.id  
      user = User.find(@user)
      user.profile.should_not == nil
      user.profile.about_me.should == "This is controller testing of profile"
    end

    it "with address using post request" do
      post :update, :profile => {:about_me => "This is location testing of profile", :gender => "male",
                    :location_attributes => {:address => "pune"}},
                    :id => @user.id  
      user = User.find(@user)
      user.profile.should_not == nil
      user.profile.about_me.should == "This is location testing of profile"
      user.profile.location.address.should == "Pune, Maharashtra, India"
    end

    it "by his image using post request"
  end
end
