require 'spec_helper'
require 'faker'

describe Nonprofit do

  context "should be created if" do
    let(:np) {Factory(:nonprofit) }
    after(:each) do
      np.save
      np.should be_valid
    end

    it "all the details entered are valid" do
      np.should be_valid
    end

    it "Organization name is already taken" do
      non = Factory.build(:nonprofit)
      non.EIN = "22111"
      non.name = np.name
      non.save
      non.should be_valid
    end

    it "cell phone is blank" do
      np.cell_phone = ""
    end
    
    it "phone number having format i.e.12223334444" do
      np.phone_number = '12223334444'
    end

    it "phone number having format i.e. 1-222-333-4444" do
      np.phone_number = '1-222-333-4444'
    end

    it "phone number having format i.e.1 222 333 4444" do
      np.phone_number = '1 222 333 4444'
    end

    it "phone number having format i.e.1-(222)-333-4444" do
      np.phone_number = '1-(222)-333-4444'
    end

    it "phone number having format i.e.1.222.333.4444" do
      np.phone_number = '1.222.333.4444'
    end

    it "phone number having format i.e.1(123)3334444" do
      np.phone_number = '1(123)3334444'
    end
    
    it "cell phone having format i.e.12223334444" do
      np.cell_phone = '12223334444'
    end

    it "cell phone having format i.e. 1-222-333-4444" do
      np.cell_phone = '1-222-333-4444'
    end

    it "cell phone having format i.e.1 222 333 4444" do
      np.cell_phone = '1 222 333 4444'
    end

    it "cell phonr having format i.e.1-(222)-333-4444" do
      np.cell_phone = '1-(222)-333-4444'
    end

    it "cell phone having format i.e.1.222.333.4444" do
      np.cell_phone = '1.222.333.4444'
    end

    it "cell phone having format i.e.1(123)3334444" do
      np.cell_phone = '1(123)3334444'
    end
  end

  context "should not be created if" do
    let(:np) {Factory(:nonprofit) }
    after(:each) do
      np.save
      np.should_not be_valid
    end
    
    it "Ein is blank" do
      np.EIN = ''
    end

    it "Ein is already taken" do
      non = Factory.build(:nonprofit)
      non.EIN = np.EIN
    end

    it "organization name is blank" do
      np.name = ""
    end

    it "if Website is blank" do
      np.website = ''
    end

    it "website is not in correct format i.e. google" do
      np.website = 'google'
    end

    it "username is blank" do
      np.username = ''
    end

    it "username is already taken" do
      non1 = Factory(:nonprofit)
      np.username = non1.username
    end

    it "confirm password is not matching with password" do
      np.password = 'josh123'
      np.password_confirmation = '123josh'
      np.update_attributes(np)
    end

    it "contact_name is blank" do
      np.contact_name = ''
    end
    
    it "position is blank" do
      np.position = ""
    end

    it "work email is blank" do
      np.email = ''
    end

    it "if email is not valid format i.e. aaa@aaa" do
      np.email = "aaa@aaa"
    end

    it "phone number is blank" do
      np.phone_number = ''
    end

    it "phone number is in wrong format i.e. 1222(333)4444" do
      np.phone_number = "1222(333)4444"
    end

    it "phone number is in wrong format i.e. 1222333(4444)" do
      np.phone_number = "1222333(4444)"
    end

    it "phone number is in wrong format i.e. 1(222)(333)(444)" do
      np.phone_number = "1(222)(333)(444)"
    end

    it "phone number is in wrong format i.e. 1-(222)-(333)-(444)" do
      np.phone_number = "1-(222)-(333)-(444)"
    end

    it "phone number is in wrong format i.e. 1-222-(333)-4444" do
      np.phone_number = "1-222-(333)-4444"
    end

    it "phone number is in wrong format i.e. -(222)-333-4444" do
      np.phone_number = "-(222)-333-4444"
    end

    it "phone number is in wrong format i.e. (222)-333-4444-" do
      np.phone_number = "(222)-333-4444-"
    end

    it "phone number is in wrong format i.e. 1--222-333-4444" do
      np.phone_number = "1--222-333-4444"
    end
    
    it "phone nuumber is in wrong format i.e. 1-      222-(333)-4444" do
      np.phone_number = "1-     222-(333)-4444"
    end
    
    it "phone number is in wrong format i.e. 1-222- (333)-  4444" do
      np.phone_number = "1-222-  (333)-   4444"
    end
    
    it "cell phone is in wrong format i.e. 1222(333)4444" do
      np.cell_phone = "1222(333)4444"
    end

    it "cell phone is in wrong format i.e. 1222333(4444)" do
      np.cell_phone = "1222333(4444)"
    end

    it "cell phone is in wrong format i.e. 1(222)(333)(444)" do
      np.cell_phone = "1(222)(333)(444)"
    end

    it "cell phone is in wrong format i.e. 1-(222)-(333)-(444)" do
      np.cell_phone = "1-(222)-(333)-(444)"
    end

    it "cell phone is in wrong format i.e. 1-222-(333)-4444" do
      np.cell_phone = "1-222-(333)-4444"
    end
    
    it "cell phone is in wrong format i.e. 1-      222-(333)-4444" do
      np.cell_phone = "1-     222-(333)-4444"
    end
    
    it "cell phone is in wrong format i.e. 1-222- (333)-  4444" do
      np.cell_phone = "1-222-  (333)-   4444"
    end
  end
end
