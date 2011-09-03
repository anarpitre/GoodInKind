require 'spec_helper'

describe ProfilesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end

  context "User profile should get updated" do
    it "by post request" do
      post :update, :profile => {:about_me => "This is controller testing of profile", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                    :id => @user.id  
      user = User.find(@user)
      user.profile.should_not == nil
      user.profile.about_me.should == "This is controller testing of profile"
    end

    it "with address using post request" do
      post :update, :profile => {:about_me => "This is location testing of profile", :gender => "male",
                    :location_attributes => {:address => "pune"}},
                    :id => @user.id  
      user = User.find(@user)
      user.profile.should_not == nil
      user.profile.about_me.should == "This is location testing of profile"
      user.profile.location.address.should == "Pune, Maharashtra, India"
    end

    it "if image is uploaded" do
      file = File.open('spec/taj.jpg')
      post :update,:profile => {:avatar => file, :about_me => "This is controller testing of image upload", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                   :id => @user.id
      @user.reload
      @user.profile.avatar_file_name.should == "taj.jpg"
      p @user.profile
    end
  end

  context "User profile should not get updated" do
    it "image uploaded is more than 2 mb" do
      file = File.open('spec/4mb.JPG')
      post :update,:profile => {:avatar => file, :about_me => "This is controller testing of image upload", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                   :id => @user.id
      @user.reload
      @user.profile.avatar_file_name.should == nil
    end
    
    it "image uploaded is in not in valid format i.e. .doc" do
      file = File.open('spec/test.doc')
      post :update,:profile => {:avatar => file, :about_me => "This is controller testing of image upload", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                   :id => @user.id
      @user.reload
      @user.profile.avatar_file_name.should_not == "test.doc"
      p @user.profile
      flash[:notice].should == "Please upload image in proer format"
    end

    it "image uploaded is not in valid format i.e. .pdf" do
      file = File.open('spec/test.pdf')
      post :update,:profile => {:avatar => file, :about_me => "This is controller testing of image upload", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                   :id => @user.id
      @user.reload
      @user.profile.avatar_file_name.should_not == "test.pdf"
      flash[:notice].should == "Please upload image in proer format"
    end
    
    it "image uploaded is not in valid format i.e. .txt" do
      file = File.open('spec/test.txt')
      post :update,:profile => {:avatar => file, :about_me => "This is controller testing of image upload", :gender => "male", :last_name => "kulkarni", :first_name => "amit"},
                   :id => @user.id
      @user.reload
      @user.profile.avatar_file_name.should_not == "test.txt"
      flash[:notice].should == "Please upload image in proer format"
    end
  end
end
