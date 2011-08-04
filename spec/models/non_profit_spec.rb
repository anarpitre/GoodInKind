require 'spec_helper'
require 'faker'

describe NonProfit do

  let(:np) {Factory(:non_profit) }
  context "should be created" do

    it "if name, contact_name, username, password, confirmation_password, email, description, EIN and valid permalink(created) are entered"do
      np.should be_valid
    end

    it "if Phone Number is not entered" do
      np.phone_number = ''
      np.should be_valid
    end

    it "if Mission_Statement is not entered" do
      np.mission_statement = ''
      np.should be_valid
    end

    it "if Website is not entered" do
      np.website = ''
      np.should be_valid
    end

    it "if Guideline is not entered" do
      np.guideline = ''
      np.should be_valid
    end
  end


  context "should not be created " do
    
    it "if name is  blank" do
      np.name = ''
      np.should_not be_valid
    end

    it "if contact_name is blank" do
      np.contact_name = ''
      np.should_not be_valid
    end

    it "if email is  blank" do
      np.email = ''
      np.should_not be_valid
    end

    it "if email is not valid format" do
      np.email = "namedh@nhsusus"
      np.should_not be_valid
    end

    it "if username is  blank" do
      np.username = ''
      np.should_not be_valid
    end

    it "if username is already taken" do
      non_profit = Factory.build(:non_profit,:username => np.username)
      non_profit.save
      non_profit.should_not be_valid
    end

    it "if uuid is  blank" do
      np.uuid = ''
      np.should_not be_valid
    end
    
    it "if password is  blank" do
      np.password = ''
      np.should_not be_valid
    end
    
    it "if confirm password is  blank" do
      np.password_confirmation = ''
      np.should_not be_valid
    end

    it "if confirm password is not matching with password" do
      np.password = 'josh123'
      np.password_confirmation = '123josh'
      np.should_not be_valid
    end

    it "if uuid is already taken" do
      non_profit = Factory.build(:non_profit,:uuid => np.uuid)
      non_profit.save
      non_profit.should_not be_valid
    end

    it "if EIN is blank" do
      np.EIN = ''
      np.should_not be_valid
    end

    it "if description is blank" do
      np.description = ''
      np.should_not be_valid
    end

    it "if photo not is not uploaded" do
      np.photo_file_name = ''
      np.should_not be_valid
    end
    it "if permalink is not set"
    it "if uploaded photo is not in proper format e.g. txt"
    it "if uploaded photo is not in proper format e.g. pdf"
    it "if uploaded photo is not in proper format e.g. word"
    it "if uploaded photo uploaded is more than 5 mb"
  end
end
