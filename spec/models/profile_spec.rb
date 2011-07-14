require 'spec_helper'

describe Profile do

  before(:each) do
    @pf = Factory(:profile)
  end
  
  context "should be created if" do
    #001
    it "all attributes entered" do
      @pf.save
      @pf.should be_valid
    end
    #002
    it "is_verified is true" do
      @pf.save
      @pf.should be_valid
    end
    #003
    it "website is blank" do
      @pf.save
      @pf.should be_valid
    end
    #004
    it "about_me is blank" do
      @pf.save
      @pf.should be_valid
    end

  end

  context "should not created if" do

    after(:each) do
      @pf.save
      @pf.should_not be_valid
    end

    #005
    it "first_name is blank" do
      @pf.first_name = nil
    end
    #006 
    it "last_name is blank" do
      @pf.last_name = nil
    end
    #007
    it "gender is blank" do
      @pf.gender = nil
    end
    #008
    it "age is blank" do
      @pf.age = nil
    end
    #009
    it "age code contains alphabetics letter" do
      @pf.age = "aabbcc"
    end




  end


end
