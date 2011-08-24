require 'spec_helper'

describe Location do

  context "should be created for service" do
    let(:location) {Factory(:service_location)}
    
    it "if Gemcoder identifies the location entered" do
      location.save
      location.should be_valid
    end

    it "if service is not offered virtualy" do
      service = location.resource
      service.is_virtual = false
      service.save
      location.should be_valid
    end
  end


  context "for service should not be created" do

    let(:location) {Factory(:service_location)}

    it "if Gemcoder dosent identifies the location entered(gemcoder result is empty string)" do
      location  = Location.new
      location.address = "no city found with this address"
      location.save
      location.should_not be_valid
    end

  end

  context "should be created for user" do

    let(:location) {Factory(:user_location)}

    it "if Gemcoder identifies the location entered" do
      location.save
      location.should be_valid
    end
  end

  context "for user should not be saved " do

    let(:location) {Factory(:user_location)}
    it "if Gemcoder dosent identifies the location entered(gemcoder result is empty string)" do
      location  = Location.new
      location.address = "no city found with this address"
      location.save
      location.should_not be_valid
    end
  end

  context "should be created for nonprofit" do

    let(:location) {Factory(:nonprofit_location)}

    it "if Gemcoder identifies the location entered" do
      location.save
      location.should be_valid
    end
  end

  context "for nonprofit should not be saved " do

    let(:location) {Factory(:nonprofit_location)}

    it "if Gemcoder dosent identifies the location entered(gemcoder result is empty string)" do
      location  = Location.new
      location.address = "no city found with this address"
      location.save
      location.should_not be_valid
    end
  end
end
