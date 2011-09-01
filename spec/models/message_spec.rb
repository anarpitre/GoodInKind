require 'spec_helper'

describe Message do
    before(:each) do
      @mes = Factory(:message)
    end
  context "should be created if" do
    it "all the details are mentioned" do
      @mes.should be_valid
      @mes.receiver.should_not == nil
      @mes.sender.should_not == nil
      @mes.parent_message_id.should == 0
      @mes.is_read.should == false
    end
  end

  context "should not be created if" do
    after(:each) do
      @mes.save
      p @mes
      @mes.should_not be_valid
    end
    it "title is blank" do
      @mes.title = ""
    end

    it "message body is blank" do
      @mes.message = ""
    end

    it "receiver is blank" do
      @mes.receiver_id = ""
    end
    
    it "sender is blank" do
      @mes.sender_id = ""
    end
  end
end
