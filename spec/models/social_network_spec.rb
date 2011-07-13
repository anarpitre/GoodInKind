require 'spec_helper'

describe SocialNetwork do

  before(:each) do
    @sn = Factory(:social_network)
    p @sn
  end

  context "should be created if" do
   #001
    it "all attributes entered" do
      @sn.save
      @sn.should be_valid
    end

  end

  context "should not be created if" do
   #002
    it "name is blank" do
      @sn.name = nil
      @sn.should_not be_valid
    end
   #003
    it "name is already taken" do
      @sn.save
      sn = SocialNetwork.create(:name => @sn.name)
      sn.should_not be_valid
    end


  end

end
