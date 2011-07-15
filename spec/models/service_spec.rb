require 'spec_helper'

describe Service do


  let(:services) { Factory(:service) }


  context " should be created and its associated user should be created if" do


    it "if booked seat is not selected" do
      services.booked_seat = ""
      services.users.should_not == nil
      services.location.should_not == nil
      services.service_categories.should_not == nil
      services.save
      services.should be_valid
    end

    it "if booking capacity is not selected" do
      services.booking_capacity = ""
      services.users.should_not == nil
      services.location.should_not == nil
      services.service_categories.should_not == nil
      services.save
      services.should be_valid
    end

    it"if is_schedules is false" do
      services.is_scheduled = false
      services.users.should_not == nil
      services.location.should_not == nil
      services.service_categories.should_not == nil
      services.save
      services.should be_valid
    end

    it"if is_public is true" do
      services.is_public = true
      services.users.should_not == nil
      services.location.should_not == nil
      services.service_categories.should_not == nil
      services.save
      services.should be_valid
    end

    it"if is_virtual is false" do
      services.is_virtual = false
      services.users.should_not == nil
      services.location.should_not == nil
      services.service_categories.should_not == nil
      services.save
      services.should be_valid
    end

  end

  context " should not be created and its associated user should not be created if" do


    it "if start_time is not selected when is_shedule true" do
      services.is_scheduled = true
      services.start_time = nil
      services.save
      services.should_not be_valid
    end

    it "if end_time is not selected when is_shedule true" do
      services.is_scheduled = true
      services.end_time = nil
      services.save
      services.should_not be_valid
    end


    it "if start_date is not selected when is_shedule true" do
      services.is_scheduled = true
      services.start_date = nil
      services.save
      services.should_not be_valid
    end


    it "if end_date is not selected when is_shedule true" do
      services.is_scheduled = true
      services.end_date = nil
      services.save
      services.should_not be_valid
    end

    it "if amount is not selected" do 
      services.amount = nil
      services.save
      services.should_not be_valid
    end

    it "amount is not alphabetical " do
      services.amount = "aabbcc"
      services.save
      services.should_not be_valid
    end

    it "if title is not selected" do 
      services.title = nil
      services.save
      services.should_not be_valid
    end

    it "if description is not selected" do
      services.description = nil
      services.save
      services.should_not be_valid
    end

    it "if non_profit_id is not selected" do
      services.non_profit_id = nil
      services.save
      services.should_not be_valid
    end

    it "if offerer_id is not selected" do
      services.offerer_id = nil
      services.save
      services.should_not be_valid
    end

    it "if is_public is not selected" do
      services.is_public = nil
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
