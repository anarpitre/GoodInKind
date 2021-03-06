require 'spec_helper'

describe User do
  
  context "Should be registered" do
    let(:user) {Factory(:user)}
    it "if email and password are provided in valid format" do 
      user.should be_valid
    end
    
    it "if provided email is in valid format i.e. a-a@aa.com" do
      user.email = 'a-a@aa.com'
      user.save
      user.should be_valid
    end
    
    it "if provided email is in valid format i.e. a-a.a@aa.com" do
      user.email = 'a-a.a@aa.com'
      user.save
      user.should be_valid
    end
    
    it "if provided email is in valid format i.e. a@a.com" do
      user.email = 'a@a.com'
      user.save
      user.should be_valid
    end
    
    it "if provided email is in valid format i.e. a@a.in" do
      user.email = 'a@a.in'
      user.save
      user.should be_valid
    end
    
    it "if provided email is in valid format i.e. a@a.org" do
      user.email = 'a@a.in'
      user.save
      user.should be_valid
    end
  end

  context "Should not be registered" do
    let(:user) {Factory(:user)}

    it "if email is blank" do
      user.email = ''
      user.save
      user.should_not be_valid
    end

    it "if provided email is not in valid format" do
      user.email = 'xxxx.com'
      user.save
      user.should_not be_valid
    end
    
    it "if provided email is not in valid format i.e. a-aa@.com" do
      user.email = 'a-aa@.com'
      user.save
      user.should_not be_valid
    end

    it "if email is already registered" do
      new_user = Factory(:user)
      new_user.email = user.email
      new_user.save
      new_user.should_not be_valid
    end

    it "if password is blank" do
      user.password = ''
      user.save
      user.should_not be_valid
    end

  end

  describe "Should not ask for password while registrations if signed up through facebook and " do
    let(:user) {Factory(:user)}

    it "if authentication exist for user" do 
      authentication = Factory(:authentication)
      user = authentication.user(:readonly => false)
      result = user.password_required?
      result.should == false
    end
  end

  describe "Should get confirmed at the time of registration" do
    let(:user) {Factory(:user)}
    it "if authentication exist for user" do 
      authentication = Factory(:authentication)
      user = authentication.user(:readonly => false)
      result = user.confirmation_required?
      result.should == false
    end
  end
end

