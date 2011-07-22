require 'spec_helper'

describe Profile do

  context "should be created if" do
    let(:pf) {Factory(:profile)}

    #001
    it "first and last name,avatar of user is uploaded and is verfied by admin" do
      pf.save
      pf.should be_valid
    end

    #002
    it "if website is blank" do
      pf.website = ""
      pf.save
      pf.should be_valid
    end

    #003
    it "if about_me is blank" do
      pf.about_me = ""
      pf.save
      pf.should be_valid
    end

    #004
    it "if gender is not entered" do
      pf.gender= ""
      pf.save
      pf.should be_valid
    end

  end

  context "should not created if" do

    let(:pf) {Factory(:profile)}

    #005 
    it "first_name is blank" do
      pf.first_name = nil
      pf.save
      pf.should_not be_valid
    end

    #006
    it "last_name is blank" do
      pf.last_name = nil
      pf.save
      pf.should_not be_valid
    end

    #007
    it "if avatar is not uploaded" do
      pf.avatar_file_name = ""
      pf.save
      pf.should_not be_valid
    end

    #008
   it "if avtar is not uploaded in proper format" do
      pf.avatar_content_type =  "/test.pdf"
      pf.save
      pf.should_not be_valid
    end

   #009
   it "if age entered is not a number" do
     pf.age = "xxxx"
     pf.save
     pf.should_not be_valid
   end

   #010
   pending "if avatar uploaded has size more than 2Mb"
  end

end
