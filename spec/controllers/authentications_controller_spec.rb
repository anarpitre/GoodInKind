require 'spec_helper'

describe AuthenticationsController do
  
  describe "should destroy user'" do
    it "should be successful" do
      authentication = Factory(:authentication)
      user = authentication.user(:readonly => false)
      sign_in user
      post :destroy, :id  => authentication.id
      u = Authentication.exists?(authentication) 
      u.should == false
    end
  end

end
