require 'spec_helper'

describe ServicesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end
  context "User should be able to" do
    it "create a service with single category" do





#      {"commit"=>"Offer it!", "service"=>{"is_schedulelater"=>"true", "start_date"=>"", "end_time"=>"", "images_attributes"=>{"0"=>{"image"=>#<ActionDispatch::Http::UploadedFile:0xb4b4a370 @original_filename="taj.jpg", @tempfile=#<File:/tmp/RackMultipart20110904-14399-o42tps-0>, @headers="Content-Disposition: form-data; name=\"service[images_attributes][0][image]\"; filename=\"taj.jpg\"\r\nContent-Type: image/jpeg\r\n", @content_type="image/jpeg">}}, "title"=>"test ser 123", "is_virtual"=>"true", "booking_capacity"=>"20", "request_id"=>"", "nonprofit_name"=>"non11", "estimated_duration"=>"0.0", "amount"=>"234", "category_ids"=>["104"], "description"=>"adls\r\nf;sd\r\n;sd\r\n]f;\r\n]s;fs", "is_public"=>"true", "nonprofit_id"=>"327", "end_date"=>"", "start_time"=>""}, "authenticity_token"=>"Zc2vXM7/hMOCH2v2Q60AP8E4W5FAASmRkJmyTRAM3Ss=", "utf8"=>"\342\234\223"}






      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      non_p.is_verified = "Verified"
      non_p.save
      post :create, :service => {:is_schedulelater => true, :title => "service-create", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :nonprofit_name => non_p.name, :is_public => true, :category_ids => ["#{cat[0]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("service-create")
      p ser
      ser.should_not == nil
    end
    
    it "create a service with multiple categories" do
      cat = Category.all.map(&:id)
      non_p = Factory(:nonprofit)
      post :create, :nonprofit_name => non_p.name,
                    :service => {:is_schedulelater => true, :title => "service-create-with-multiple-category", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => non_p.id}
      ser = Service.find_by_title("service-create-with-multiple-category")
      ser.should_not == nil
    end

    it "create a service with same non-profit" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :create, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :title => "service-with-same-nonp", :is_virtual => true, :booking_capacity => 25, :estimated_duration => 45, :amount => 200, :description => "testing of creation of service", :is_public => true, :category_ids => ["#{cat[0]}, #{cat[1]}, #{cat[2]}"],:nonprofit_id => ser.nonprofit.id}
      ser1 = Service.find_by_title("service-with-same-nonp")
      ser1.should_not == nil
      ser.nonprofit.name.should == ser1.nonprofit.name
    end

    it "update a service" do
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
                    :service => { :title => "ser_update"},
                    :id => ser.permalink
      ser_old = Service.find_by_title(ser.title)
      ser_old.should == nil
      ser_new = Service.find_by_title("ser_update")
      ser_new.should_not == nil
    end

    it "delete a service"
    
    it "upload image" do
      file = File.open('spec/taj.jpg')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
                    :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should_not == nil
      ser1.images.first.image_file_name.should == "taj.jpg"
    end

    it "uploaded logo is not in proper format e.g. txt" do
      file = File.open('spec/test.txt')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
                    :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo is not in proper format e.g. pdf" do
      file = File.open('spec/test.pdf')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
                    :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo is not in proper format e.g. word" do
      file = File.open('spec/test.doc')
      cat = Category.all.map(&:id)
      ser = Factory(:service)
      post :update, :nonprofit_name => ser.nonprofit.name,
                    :service => {:is_schedulelater => true, :images_attributes => {"0" => { :image => file }}}, 
                    :id => ser.permalink
      ser1 = Service.find_by_title(ser.title)
      ser1.should_not == nil
      ser1.images.should == []
    end

    it "uploaded logo uploaded is more than 5 mb"
  end
end
