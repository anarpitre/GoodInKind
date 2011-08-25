require 'spec_helper'

describe Profile do

  let(:pf) {Factory(:profile)}
  context "of user should be created if" do
    after(:each) do
      pf.save
      pf.should be_valid
    end
    it "first_name is blank" do
      pf.first_name = nil
    end

    it "last_name is blank" do
      pf.last_name = nil
    end

    it "if gender is not entered" do
      pf.gender= ""
    end

    it "website is blank" do
      pf.website = ""
    end

    it "if about_me is blank" do
      pf.about_me = ""
    end

    it "if avatar is not uploaded" do
      pf.avatar_file_name = ""
    end

  end

  context "should not created if" do

    after(:each) do
      pf.save
      pf.should_not be_valid
    end

    it "website address is not in proper format" do
      pf.website = "google"
    end

    it "if avtar is not uploaded in proper format" do
      pf.avatar_content_type =  "/test.pdf"
    end

    it "if avtar is not uploaded in proper format" do
      pf.avatar_content_type =  "/test.doc"
    end

    it "if avtar is not uploaded in proper format" do
      pf.avatar_content_type =  "/test.txt"
    end
  end
end
