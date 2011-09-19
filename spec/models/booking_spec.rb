require 'spec_helper'

describe Booking do
  context "should be made if" do
    it "all the details entered are valid" do
      b = Factory(:booking)
      p b
      b.b.user
      b.b.service
    end

    it "additional donation amount is entered is 0"

    it "address line 2 is not entered"

    it "address line 3 is not entered"
    
    it "additional donation field is entered in floating i.e. 22.22"
  end

  context "should not be made if" do
    it "no. of spots to buy field contains alpha numeric"

    it "no. of spots to buy field is entered 0"

    it "additional donation field is contains alpha numeric values"

    it "name is blank"

    it "credit card number is blank"

    it "credit card number is not less than 16 digits"

    it "credit card number is in wrong format"

    it "cvv number is blank"

    it "cvv number is wrong"

    it "cvv numbercontains alphanumeric characters"

    it "card is expired"

    it "expiration date is less than current date"

    it "bill to field is blank"

    it "address line is blank"

    it "city is blank"

    it "state is blank"

    it "zipcode is blank"

    it "country is blank"
  end
end
