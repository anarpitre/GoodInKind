require 'spec_helper'

describe Service do

  context "should be saved if"
  
  before(:each) do
    @service = Factory.build(:service)
  end
  
  it "if all the credentials are provided" do
    @service.should be_valid
  end

  it "if booking capacity is not selected" do
    @service.booking_capacity = ""
    @service.save
    @service.should be_valid
  end

  context "should not be saved if"
  
  before(:each) do
    @service = Factory.build(:service)
  end
  
  it "if start_time is not selected when is_shedule true" do
    @service.start_time = nil
    @service.save
    @service.should_not be_valid
  end
  
  it "if start_time is not selected when is_shedule true" do
    @service.end_time = nil
    @service.save
    @service.should_not be_valid
  end

  
  it "if start_time is not selected when is_shedule true" do
    @service.start_date = nil
    @service.save
    @service.should_not be_valid
  end

  
  it "if start_time is not selected when is_shedule true" do
    @service.end_date = nil
    @service.save
    @service.should_not be_valid
  end

  it "if amount is not selected" do 
    @service.amount = nil
    @service.save
    @service.should_not be_valid
  end
  
  it "if title is not selected" do 
    @service.title = nil
    @service.save
    @service.should_not be_valid
  end
  
  it "if description is not selected" do
    @service.description = nil
    @service.save
    @service.should_not be_valid
  end
  
  it "if charity_id is not selected" do
    @service.charity_id = nil
    @service.save
    @service.should_not be_valid
  end
  
  it "if priority is not selected" do
    @service.priority = nil
    @service.save
    @service.should_not be_valid
  end

  it "if logo not is not uploaded" 

  it "uploaded logo is not in proper format e.g. txt"

  it "uploaded logo is not in proper format e.g. pdf"
  
  it "uploaded logo is not in proper format e.g. word"

  it "uploaded logo uploaded is more than 5 mb"
end
