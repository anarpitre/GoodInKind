require 'spec_helper'

describe NonProfit do

  before(:each) do
    @charity = Factory(:non_profit)
  end

  context "should be created if " do 
    #001   
    it "all attributes entered" do
      @charity.save
      @charity.should be_valid
    end
    #002
    it "name is already taken" do
      @charity.save
      charity = Charity.create(:name => @charity.name, :EIN => @charity.EIN, :description => @charity.description)
      charity.should_not be_valid
    end

  end

  context "should not be created if" do

    #003
    it "name is blank" do
      @charity.name = nil
      @charity.should_not be_valid
    end
    #004
    it "EIN is blank" do
      @charity.EIN = nil
      @charity.should_not be_valid
    end
    #005
    it "description is blank" do
      @charity.description = nil
      @charity.should_not be_valid
    end

  end

end
