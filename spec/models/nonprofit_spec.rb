require 'spec_helper'
require 'faker'

describe Nonprofit do
  
  context "should be created if" do
  let(:np) {Factory(:nonprofit) }
  after(:each) do
    np.save
    np.should be_valid
  end

    it "all the details entered are valid" do
      np.should be_valid
    end
    
    it "Ein is blank" do
      np.EIN = ''
    end

    it "Organization name is already taken" do
      non = Factory(:nonprofit)
      non.name = np.name
      non.save
      non.should be_valid
    end

    it "if Website is blank" do
      np.website = ''
      np.should be_valid
    end

    it "logo is not selected"

    it "position is blank" do
      np.position = ""
    end

    it "cell phone is blank" do
      np.cell_phone = ""
    end
  end

  context "should not be created if" do
  let(:np) {Factory(:nonprofit) }
   after(:each) do
      np.save
      p np.password
      p np.password_confirmation
     np.should_not be_valid
    end

    it "Ein is already taken"

    it "organization name is blank" do
      p np
      np.name = ""
    end

    it "website is not in correct format i.e. google" do
      np.website = 'google'
    end
    
    it "username is blank" do
      np.username = ''
    end
    
    it "username is already taken" do
      non1 = Factory(:nonprofit)
      np.username = non1.username
    end
    
    it "confirm password is not matching with password" do
      np.password = 'josh123'
      np.password_confirmation = '123josh'
      np.update_attributes(np)
    end

    it "contact_name is blank" do
      np.contact_name = ''
    end

    it "work email is blank" do
      np.email = ''
    end

    it "if email is not valid format i.e. aaa@aaa" do
      np.email = "aaa@aaa"
    end

    it "phone number is blank" do
      np.phone_number = ''
    end

    it "if photo not is not uploaded" do
      np.photo_file_name = ''
      np.should_not be_valid
    end
    
    it "if uuid is  blank"
    it "if permalink is not set"
    it "if uploaded photo is not in proper format e.g. txt"
    it "if uploaded photo is not in proper format e.g. pdf"
    it "if uploaded photo is not in proper format e.g. word"
    it "if uploaded photo uploaded is more than 5 mb"
  end
end
