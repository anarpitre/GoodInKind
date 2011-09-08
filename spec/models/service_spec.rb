require 'spec_helper'

describe Service do
  context "should be created if" do
    before(:each) do
      @services = Factory(:service)
    end
    after(:each) do
      @services.should be_valid
    end

    it "all the details are entered" do
      @services.should be_valid
    end

    it "start time is greater than end time if start date is greater then end date" do
      @services.start_time = "2:00pm"
      @services.end_time = "1:30am"
    end

    it "schedule later is true and date and time is not entered" do
      @services.is_schedulelater = true
      @services.start_date = ""
      @services.end_date = ""
      @services.start_time = ""
      @services.end_time = ""
      @services.save
    end

    it "public posting is checked for privacy setting" do
      @services.is_public = true
      @services.save
    end
    
    it "private posting is checked for privacy setting" do
      @services.is_public = false
      @services.save
    end

    it "online service is checked and address is not entered" do
      @services.is_virtual = true
      @services.save
    end
    
    it "online service is not checked and address is entered" do
      @services.is_virtual = false
      ser_loc = @services.build_location
      ser_loc.address = "Ithaca"
      ser_loc.save
      loc = Location.last
      loc.should_not == nil
      @services.save
    end
  end

  context "should not be created if" do
    before(:each) do
      @services = Factory(:service)
      @services.nonprofit
    end

    after(:each) do
      @services.save
      @services.should_not be_valid
    end

    it "title is blank" do 
      @services.title = nil
    end

    it "description is blank" do
      @services.description = nil
    end
    
    it "online service is not checked and address is blank" do
      ser_loc = @services.build_location
      ser_loc.address = ""
      ser_loc.save
    end
    
    it "category ids is not selected" do
      @services.service_categories.first.destroy
      @services.reload
      @services.should_not be_valid
    end
    
    it "booking capacity blank" do
      @services.booking_capacity = ""
      @services.save
    end

    it "estimated duration is blank" do
      @services.estimated_duration = ""
      @services.save
    end
    
    it "start date is blank" do
      @services.start_date = ""
    end
    
    it "end date is blank" do
      @services.end_date = ""
    end
    
    it "start date is in wrong format i.e. dd/mm/yyyy" do
      @services.start_date = "23/08/2011"
    end

    it "end date is in wrong format i.e. dd/mm/yyyy" do
      @services.end_date = "23/08/2011"
    end
    
    it "start date is greater than end date" do
      @services.start_date = Date.today + 3.days
      @services.end_date = Date.today + 1.days
    end

    it "if start_date is not selected when is_shedulelater is false" do
      @services.is_schedulelater = false
      @services.start_date = nil
    end

    it "end_date is not selected when is_shedulelater is false" do
      @services.is_schedulelater = false
      @services.end_date = nil
    end
    
    it "start time is blank" do
      @services.start_time = ""
    end
    
    it "end time is blank" do
      @services.end_time = ""
    end

    
    it "start time is equal to end time if date is current date" do
      @services.start_date = Date.today
      @services.end_date = Date.today
      @services.start_time = "2:00pm"
      @services.end_time = "2:00am"
    end

    it "amount is blank" do 
      @services.amount = ""
    end

    it "amount entered is non-numeric" do
      @services.amount = "aabbcc"
    end

  end
  context "Service should not be created" do
    it "if nonprofit_id is not selected" do
      ser = Factory.build(:service)
      ser.nonprofit_id = ""
    end
  end
end
