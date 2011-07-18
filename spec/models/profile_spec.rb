require 'spec_helper'

describe Profile do

  before(:each) do
    @pf = Factory(:profile)
  end
  
  context "should be created if" do
    #001
    it "is_verified is true" do
      @pf.save
      @pf.should be_valid
    end
    #002
    it "website is blank" do
      @pf.save
      @pf.should be_valid
    end
    #003
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

    #004
    it "first_name is blank" do
      @pf.first_name = nil
    end
    #005 
    it "last_name is blank" do
      @pf.last_name = nil
    end
    #006
    it "gender is blank" do
      @pf.gender = nil
    end




  end


end
