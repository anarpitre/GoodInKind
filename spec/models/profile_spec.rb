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
    #005
    it "first_name is blank" do
      @pf.first_name = nil
      @pf.should_not be_valid
    end
    #006 
    it "last_name is blank" do
      @pf.last_name = nil
      @pf.should_not be_valid
    end
    #007
    it "gender is blank" do
      @pf.gender = nil
      @pf.should_not be_valid
    end
    #008
    it "age is blank" do
      @pf.age = nil
      @pf.should_not be_valid
    end



  end


end
