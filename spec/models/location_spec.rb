require 'spec_helper'

describe Location do
  
  context "should be saved if"
  
  before(:each) do
    @location = Factory.build(:location)
  end
  
  it "if all the credentials are provided" do
    @location.should be_valid
  end

  it "if latitude is not selected" do
    @location.latitude = ""
    @location.save
    @location.should be_valid
  end

  it "if longitude is not selected" do
    @location.latitude = ""
    @location.save
    @location.should be_valid
  end
  
  it "if mobile is not selected" do
    @location.mobile = ""
    @location.save
    @location.should be_valid
  end

  context "should not be saved if"
  
  before(:each) do
    @location = Factory.build(:location)
  end
  
  it "if locality is not entered" do 
    @location.locality = nil
    @location.save
    @location.should_not be_valid
  end

  
  it "if city is not selected" do 
    @location.city = nil
    @location.save
    @location.should_not be_valid
  end
  
  it "if state is not selected" do 
    @location.state = nil
    @location.save
    @location.should_not be_valid
  end
  
  it "if country is not selected" do 
    @location.country = nil
    @location.save
    @location.should_not be_valid
  end
  
  it "if is phone not entered" do 
    @location.phone = nil
    @location.save
    @location.should_not be_valid
  end
  
  it "if email is not entered" do 
    @location.email = nil
    @location.save
    @location.should_not be_valid
  end





end
