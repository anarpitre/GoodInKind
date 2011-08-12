require 'spec_helper'

describe "services/edit.html.haml" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :title => "MyString",
      :description => "MyString",
      :amount => 1.5,
      :booking_capacity => 1,
      :is_scheduled => false,
      :nonprofit_id => 1,
      :is_virtual => false,
      :is_public => false
    ))
  end

  it "renders the edit service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => services_path(@service), :method => "post" do
      assert_select "input#service_title", :name => "service[title]"
      assert_select "input#service_description", :name => "service[description]"
      assert_select "input#service_amount", :name => "service[amount]"
      assert_select "input#service_booking_capacity", :name => "service[booking_capacity]"
      assert_select "input#service_is_scheduled", :name => "service[is_scheduled]"
      assert_select "input#service_nonprofit_id", :name => "service[nonprofit_id]"
      assert_select "input#service_is_virtual", :name => "service[is_virtual]"
      assert_select "input#service_is_public", :name => "service[is_public]"
    end
  end
end
