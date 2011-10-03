require 'spec_helper'

describe BookingsController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
    @ser = Factory(:service)
    p @ser
    @non = @ser.nonprofit
    @non.uuid = "0346acc0-2024-11e0-a279-4061860da51d"
    @non.is_verified = "Verified"
    @non.save
    p @non
  end
  context "booking should be done" do
    it "if all the attributes are given" do
      post :create, :cc => { :name => "Amit Kulkarni", :number => "4457010000000009", :month => "1", :type => "visa", :year => "2012", :verification_value => "123"},
      :booking => {:billToAddressLine1 => "Pune", :billToCountry => "US", :billToAddressLine2 => "Pashan", :billToAddressLine3 => "Baner", :accountName => "amit kulkarni", :billToCity => "Newyork", :billToState => "NY", :seats_booked => "1", :additional_donation_amount => "0.0", :billToZip => "12345"}, 
      :service_id => @ser.permalink
      ser = Service.find(@ser.id)
      ser.bookings.should_not == nil
      p ser.bookings
    end
  end
end
