require 'spec_helper'

describe "services/edit.html.erb" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :title => "MyString",
      :description => "MyString",
      :amount => 1.5,
      :booking_capacity => 1,
      :booked_seats => 1,
      :is_scheduled => false,
      :non_profit_id => 1,
      :group_number => 1,
      :non_profit_percentage => 1.5,
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
      assert_select "input#service_booked_seats", :name => "service[booked_seats]"
      assert_select "input#service_is_scheduled", :name => "service[is_scheduled]"
      assert_select "input#service_non_profit_id", :name => "service[non_profit_id]"
      assert_select "input#service_group_number", :name => "service[group_number]"
      assert_select "input#service_non_profit_percentage", :name => "service[non_profit_percentage]"
      assert_select "input#service_is_virtual", :name => "service[is_virtual]"
      assert_select "input#service_is_public", :name => "service[is_public]"
    end
  end
end
