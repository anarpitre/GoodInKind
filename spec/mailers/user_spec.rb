require "spec_helper"

describe User do

  context "Email should be sent to user when "
  before(:each) do
    ActionMailer::Base.deliveries = []
    let(:user) {Factory.create(:user)}
  end

  it "activation mail should be sent after user is created" do
    ActionMailer::Base.deliveries.first.to.should == [user.email]
  end
  it "new password should be sent through email if user with email exist"

  context "Email should not  be sent to user when "
  it "new password should not be sent if password given do not match with email provided"
  it "no email should be sent if with provided email no user is registered"

end
