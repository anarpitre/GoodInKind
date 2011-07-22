require 'spec_helper'
require 'faker'

describe NonProfit do

  let(:np) { Factory(:non_profit)}

  context "should be created  " do 

    it "if name,contact_name,EIN,username,password,uuid,description,EIN should be entered" do
      np.save
      np.should be_valid
    end

    it "if PhoneNumber is blank" do
      np.phone_number = nil
      np.save
      np.should be_valid
    end

  end


  context "should not be created " do

    it "if name is  blank" do
      np.name = nil
      np.save
      np.should_not be_valid
    end

    it "if contact_name is blank" do
      np.contact_name = nil
      np.save
      np.should_not be_valid
    end

    it "if email is  blank" do
      np.email = nil
      np.save
      np.should_not be_valid
    end

    it "if email is not valid format" do
      np.email = "namedh@nhsusus"
      np.save
      np.should_not be_valid
    end

    it "if username is  blank" do
      np.username = nil
      np.save
      np.should_not be_valid
    end

    it "if username is already taken" do
      non_profit = Factory.build(:non_profit,:username => np.username)
      non_profit.save
      non_profit.should_not be_valid
    end
     
      
    it "if uuid is  blank" do
      np.uuid = nil
      np.save
      np.should_not be_valid
    end

    it "if uuid is already taken" do
      non_profit = Factory.build(:non_profit,:uuid => np.uuid)
      non_profit.save
      non_profit.should_not be_valid
    end

    it "if EIN is blank" do
      np.EIN = nil
      np.save
      np.should_not be_valid
    end

    it "if description is blank" do
      np.description = nil
      np.save
      np.should_not be_valid
    end

  end

end
