require 'spec_helper'

describe User do
  context "Should be saved if"

  
  it "if all the crendtials are provided" do 
    @user.save
  end
  
  context "Should not be saved if"
  
  before(:each) do
    @user= Factory.build(:user)
  end
  
  it "if email is not provided" do
    @user.email = ''
    @user.save
    @user.should_not be_valid
  end

  it "if role (whether admin or not) is not specified" do
    @user.is_admin = ''
    @user.save
    @user.should_not be_valid
  end

end
