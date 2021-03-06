require 'spec_helper'
require 'faker'

describe Nonprofit do

  context "should be created if" do
    let(:np) {Factory(:nonprofit) }
    after(:each) do
      np.save
      np.should be_valid
    end
    
    it "EIN format is valid i.e. 11-1111111" do
      np.EIN = "11-1111111"
    end
    
    it "Ein is format is invalid i.e.12345678" do
      np.EIN = '12345678'
    end
    
    it "Ein is format is invalid i.e.12-3456789" do
      np.EIN = '12-3456789'
    end

    it "Ein is format is invalid i.e.12.345678" do
      np.EIN = '12.345678'
    end


    it "all the details entered are valid" do
      np.should be_valid
    end

    it "Organization name is already taken" do
      non = Factory.build(:nonprofit)
      non.EIN = "11-2211145"
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

    it "cell phone having format i.e.1(123)3334444" do
      np.cell_phone = '1(123)3334444'
    end
    
    it "website is not in correct format i.e. google" do
      np.website = 'google'
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
    
    it "organization name is blank" do
      np.name = ""
    end

    it "if Website is blank" do
      np.website = ''
    end

    it "username is blank" do
      np.username = ''
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
    
    it "phone number having format i.e.1.222.333.4444" do
      np.phone_number = '1.222.333.4444'
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
    
    it "cell phone having format i.e.1.222.333.4444" do
      np.cell_phone = '1.222.333.4444'
    end

  end
    
  context "Nonprofit user should not be created if" do
    it "EIN is already taken" do
      np = Factory(:nonprofit)
      non = Factory.build(:nonprofit)
      non.EIN = np.EIN
      non.save
      non.should_not be_valid
    end
    
    it "username is already taken" do
      np = Factory(:nonprofit)
      non1 = Factory.build(:nonprofit)
      non1.EIN = "33-3322112"
      non1.username = np.username
      non1.save
      non1.should_not be_valid
    end
  end
end
