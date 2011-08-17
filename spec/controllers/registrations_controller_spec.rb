require 'spec_helper'

describe RegistrationsController do
  before(:each) do
#    @request.env['devise.mapping'] = :user
  end
  context "User should be successfully registered" do
    it "by post request" do
      post :create, :user =>{:password_confirmation => "user12345", :password => "user12345", :email => "user123@user.com"}
      u = User.find_by_email("user123@user.com")
      u.should_not == nil
    end
  end
end
