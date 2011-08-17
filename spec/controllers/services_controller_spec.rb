require 'spec_helper'

describe ServicesController do
  before(:each) do
    @user = Factory(:user)
    @request.env['devise.mapping'] = :user
    sign_in @user
  end
  context "User should be able to" do

  # This should return the minimal set of attributes required to create a valid
  # Service. As you add validations to Service, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :title => "MyString",
      :description => "MyString",
      :amount => 1.5,
      :booking_capacity => 1,
      :is_schedulelater => true,
      :nonprofit_id => 1,
      :is_virtual => false,
      :is_public => true
    }
  end

  describe "GET index" do
    it "create a service"

    it "assigns all services as @services" do
      service = Service.create! valid_attributes
      get :index
      assigns(:services).should_not eq([service])
    end
  end

  describe "GET show" do
    it "assigns the requested service as @service" do
      service = Service.create! valid_attributes
      get :show, :id => service.id.to_s
      assigns(:service).should eq(service)
    end
  end
    it "create a service with same non-profit"

    it "update a service"

    it "delete a service"
  end
end
