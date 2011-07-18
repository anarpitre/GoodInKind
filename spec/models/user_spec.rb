require 'spec_helper'

describe User do
  context "Should be saved if"
  let(:user) {Factory(:user)}

  it "if email_id and password are provided in valid format" do 
    user.save
    user.should be_valid
  end

  context "Should not be saved if"
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

  it "if email is already registered" do
    user.email = "pratik@joshsoftware.com"
    user.save
    user.should_not be_valid
  end

  it "if password is blank" do
    user.password = ''
    user.save
    user.should_not be_valid
  end

  it "if role (whether admin or not) is not specified" do
    user.is_admin = ''
    user.save
    user.should_not be_valid
  end

End
