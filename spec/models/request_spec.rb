require 'spec_helper'

describe Request do
  before(:each) do
    @req = Factory(:request)
  end
  context "Service request should be created if" do

    after(:each) do
      @req.save
      @req.should be_valid
    end
    it "all the details are valid" do
      @req.save
    end

    it "title is already taken" do
      req = Factory(:request)
      @req.title = req.title
    end
  end

  context "Service request should be created if" do
    after(:each) do
      @req.save
      @req.should_not be_valid
    end
    it "title is blank" do
      @req.title = ""
    end

    it "Description is blank" do
      @req.description = ""
    end

    it "email is blank" do
      @req.email = ""
    end

    it "email format is wrong i.e. www@www" do
      @req.email = "www@www"
    end
  end
end
