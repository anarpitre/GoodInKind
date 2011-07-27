require 'spec_helper'
require 'faker'

describe NonProfit do


  context "should not be created " do
    let(:np) { Factory(:non_profit)}
    
    it "if name is  blank" do
      np.name = ''
      np.save
      np.should_not be_valid
    end

    it "if contact_name is blank" do
      np.contact_name = ''
      np.save
      np.should_not be_valid
    end

    it "if email is  blank" do
      np.email = ''
      np.save
      np.should_not be_valid
    end

    it "if email is not valid format" do
      np.email = "namedh@nhsusus"
      np.save
      np.should_not be_valid
    end

    it "if username is  blank" do
      np.username = ''
      np.save
      np.should_not be_valid
    end

    it "if username is already taken" do
      non_profit = Factory.build(:non_profit,:username => np.username)
      non_profit.save
      non_profit.should_not be_valid
    end

    it "if uuid is  blank" do
      np.uuid = ''
      np.save
      np.should_not be_valid
    end
    
    it "if password is  blank" do
      np.password = ''
      np.save
      np.should_not be_valid
    end
    
    it "if confirm password is  blank" do
      np.password_confirmation = ''
      np.save
      np.should_not be_valid
    end

    it "if uuid is already taken" do
      non_profit = Factory.build(:non_profit,:uuid => np.uuid)
      non_profit.save
      non_profit.should_not be_valid
    end

    it "if EIN is blank" do
      np.EIN = ''
      np.save
      np.should_not be_valid
    end

    it "if description is blank" do
      np.description = ''
      np.save
      np.should_not be_valid
    end
  end
end
