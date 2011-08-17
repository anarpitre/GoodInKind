require 'spec_helper'

describe Service do
  let(:services) { Factory(:service) }
  context "should be created if" do

    it "all the details are entered"

    it "category ids is not selected"

    it "start time is blank"

    it "end time is blank"

    it "booking capacity blank " do
      services.booking_capacity = ""
      services.save
      services.should be_valid
    end

    it"if is_schedulelater is true" do
      services.is_schedulelater = true 
    it "estimated duration is blank"

    it "is_schedules is false" do
      services.is_scheduled = false
      services.save
      services.should be_valid
    end

    it "public posting is checked for privacy setting" do
      services.is_public = true
      services.save
      services.should be_valid
    end

    it "is_virtual is not select" do
      services.is_virtual = false
      services.save
      services.should be_valid
    end
    
    it "if is_public is not selected" do
      services.is_public = nil
      services.save
      services.should_not be_valid
    end
  end

  context " should not be created and its associated user should not be created " do

    it "if start_date is not selected when is_shedulelater is false" do
      services.is_schedulelater = false
      services.start_date = nil
      services.save
      services.should_not be_valid
    end

    it "if end_date is not selected when is_shedulelater is false" do
      services.is_schedulelater = false
      services.end_date = nil
    
    it "description is blank" do
      services.description = nil
      services.save
      services.should_not be_valid
    end

    it "address is blank"

    it "start date is blank"

    it "start date is in wrong format i.e. dd/mm/yyyy"
    
    it "end date is in wrong format i.e. dd/mm/yyyy"

    it "start_date is not selected when is_shedule true" do
      services.is_scheduled = true
      services.start_date = nil
      services.save
      services.should_not be_valid
    end

    it "end_date is not selected when is_shedule true" do
      services.is_scheduled = true
      services.end_date = nil
      services.save
      services.should_not be_valid
    end

    it "start date is greater than end date"

    it "start time is greater than end time"

    it "amount is blank" do 
      services.amount = nil
      services.save
      services.should_not be_valid
    end

    it "amount entered is non-numeric" do
      services.amount = "aabbcc"
      services.save
      services.should_not be_valid
    end

    it "if nonprofit_id is not selected" do
      services.nonprofit_id = nil
      services.save
      services.should_not be_valid
    end

    it "if logo not is not uploaded"

    it "uploaded logo is not in proper format e.g. txt"

    it "uploaded logo is not in proper format e.g. pdf"

    it "uploaded logo is not in proper format e.g. word"

    it "uploaded logo uploaded is more than 5 mb"
  end
end
