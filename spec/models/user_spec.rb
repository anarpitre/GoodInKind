require 'spec_helper'

describe User do
  
  context "Should be registered" do
    let(:user) {Factory(:user)}

    #001
    it "if email_id and password are provided in valid format" do 
      user.save
      user.should be_valid
    end
  end

  context "Should not be registered" do
    let(:user) {Factory(:user)}

    #002
    it "if email is blank" do
      user.email = ''
      user.save
      user.should_not be_valid
    end

    #003
    it "if provided email is not in valid format" do
      user.email = 'xxxx.com'
      user.save
      user.should_not be_valid
    end

    #004
    it "if email is already registered" do
      new_user = Factory(:user)
      new_user.email = user.email
      new_user.save
      new_user.should_not be_valid
    end

    #005
    it "if password is blank" do
      user.password = ''
      user.save
      user.should_not be_valid
    end

  end

  describe "Should not ask for password while registrations" do
    let(:user) {Factory(:user)}

    #006
    it "if authentication exist for user" do 
      authentication = Factory(:authentication)
      user = authentication.user(:readonly => false)
      result = user.password_required?
      result.should == false
    end
  end

  describe "Should get confirmed at the time of registration" do
    let(:user) {Factory(:user)}

    #007
    it "if authentication exist for user" do 
      authentication = Factory(:authentication)
      user = authentication.user(:readonly => false)
      result = user.confirmation_required?
      result.should == false
    end
  end

end

