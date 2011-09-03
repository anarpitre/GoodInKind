require 'spec_helper'

describe MessagesController do
  context "Message should be" do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end
    it "created using post request" do
      user = Factory(:user)
      post :create, :message => { :parent_message_id => "0", :title => "message-testing", :receiver_id => user.id, :message => "This is message description"}
      mes = Message.last
      mes.title.should == "message-testing"
      mes.receiver_id.should == user.id
      mes.sender_id.should == @user.id
    end
  end
end
