require 'spec_helper'

describe ProfilesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end

  context "User profile should be created" do
    it "by post request" do
    post :create, :profile => {:about_me => "This is controller testing of profile", :gender => "male", :last_name => "kulkarni", :first_name => "amit"}
    @user.profile.should_not == nil
    @user.profile.about_me.should == "This is controller testing of profile"
    end
  end
end
