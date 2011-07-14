require 'spec_helper'

describe NonProfit do

  before(:each) do
    @np = Factory(:non_profit)
  end

  context "should be created if " do 

    #001   
    it "all attributes entered" do
      puts @np
      @np.save
      @np.should be_valid
    end
    #002
    it "name is already taken" do
      @np.save
      np = NonProfit.create(:name => @np.name, :description => @np.description, :EIN => @np.EIN)
      np.should_not be_valid
    end

  end

    context "should not be created if" do
        after(:each) do
          @np.save
          @np.should_not be_valid
        end

      #003
      it "name is blank" do
        @np.name = nil
      end
      #004
      it "EIN is blank" do
        @np.EIN = nil
      end
      #005
      it "description is blank" do
        @np.description = nil
      end
      

    end

  end
