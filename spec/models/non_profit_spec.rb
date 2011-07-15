require 'spec_helper'
require 'faker'

describe NonProfit do

  let(:np) { Factory(:non_profit)}

  context "should be created if " do 

    it "name is not blank" do
      np.name = Faker::Name.name
      np.save
      np.should be_valid
    end

    it "EIN is not blank" do
      np.EIN = "12345"
      np.save
      np.should be_valid
    end

    it " description is not blank" do
      np.description = Faker::Lorem.paragraph
      np.save
      np.should be_valid
    end

  end

  context "should not be created if" do

    it "name is blank" do
      np.name = nil
      np.save
      np.should_not be_valid
    end
    it "EIN is blank" do
      np.EIN = nil
      np.save
      np.should_not be_valid
    end
    it "description is blank" do
      np.description = nil
      np.save
      np.should_not be_valid
    end


  end

end
