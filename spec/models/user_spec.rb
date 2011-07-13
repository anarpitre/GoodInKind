require 'spec_helper'

describe User do
  context "Should be saved if"

  before(:each) do
    @user= Factory.build(:user)
  end
  
  it "if all the crendtials are provided" do 
    @user.save
  end
  
  context "Should not be saved if"
  it "if email is not provided"

  it "if password is not provided"
  it "if password do not match"
end
