require 'spec_helper'

describe Service do


  let(:services) { Factory(:service) }
  context " should be created and its associated user should be created " do

    it "if title, description, nonprofit_id, amount are entered" do
      services.save
      services.should be_valid
    end
    it "if booked seats is not selected" do
      services.booked_seats = ""
      services.save
      services.should be_valid
    end

    it "if booking capacity is not selected" do
      services.booking_capacity = ""
      services.save
      services.should be_valid
    end

    it"if is_schedulelater is true" do
      services.is_schedulelater = true 
      services.save
      services.should be_valid
    end

    it"if is_public is  selected" do
      services.is_public = true
      services.save
      services.should be_valid
    end

    it"if is_virtual is not select" do
      services.is_virtual = false
      services.save
      services.should be_valid
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
      services.save
      services.should_not be_valid
    end

    it "if amount is not selected" do 
      services.amount = nil
      services.save
      services.should_not be_valid
    end

    it "if amount is not alphabetical " do
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

    it "if nonprofit_id is not selected" do
      services.nonprofit_id = nil
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
