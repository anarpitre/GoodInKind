require 'spec_helper'
require 'faker'

describe NonProfit do

  let(:np) {Factory(:non_profit) }
  context "should be created" do

    #001
    it "if name, contact_name, username, password, confirmation_password, email, description, EIN and valid permalink(created) are entered"do
      np.should be_valid
    end
    #002
    it "if Phone Number is not entered" do
      np.phone_number = ''
      np.should be_valid
    end
    
    #003
    it "if Mission_Statement is not entered" do
      np.mission_statement = ''
      np.should be_valid
    end
    
    #004
    it "if Website is not entered" do
      np.website = ''
      np.should be_valid
    end
    #005
    it "if Guideline is not entered" do
      np.guideline = ''
      np.should be_valid
    end
  end


  context "should not be created " do
    
    #006
    it "if name is  blank" do
      np.name = ''
      np.should_not be_valid
    end

    #007
    it "if contact_name is blank" do
      np.contact_name = ''
      np.should_not be_valid
    end

    #008
    it "if email is  blank" do
      np.email = ''
      np.should_not be_valid
    end

    #009
    it "if email is not valid format" do
      np.email = "namedh@nhsusus"
      np.should_not be_valid
    end

    #010
    it "if username is  blank" do
      np.username = ''
      np.should_not be_valid
    end

    #011
    it "if username is already taken" do
      non_profit = Factory.build(:non_profit,:username => np.username)
      non_profit.save
      non_profit.should_not be_valid
    end

    #012
    it "if uuid is  blank" do
      np.uuid = ''
      np.should_not be_valid
    end
    
    #013
    it "if password is  blank" do
      np.password = ''
      np.should_not be_valid
    end
    
    #014
    it "if confirm password is  blank" do
      np.password_confirmation = ''
      np.should_not be_valid
    end

    #015
    it "if confirm password is not matching with password" do
      np.password = 'josh123'
      np.password_confirmation = '123josh'
      np.should_not be_valid
    end

    #016
    it "if uuid is already taken" do
      non_profit = Factory.build(:non_profit,:uuid => np.uuid)
      non_profit.save
      non_profit.should_not be_valid
    end

    #017
    it "if EIN is blank" do
      np.EIN = ''
      np.should_not be_valid
    end

    #018
    it "if description is blank" do
      np.description = ''
      np.should_not be_valid
    end

    #019
    it "if photo not is not uploaded" do
      np.photo_file_name = ''
      np.should_not be_valid
    end
    #020
    it "if permalink is not set"
    it "if uploaded photo is not in proper format e.g. txt"
    it "if uploaded photo is not in proper format e.g. pdf"
    it "if uploaded photo is not in proper format e.g. word"
    it "if uploaded photo uploaded is more than 5 mb"
  end
end
