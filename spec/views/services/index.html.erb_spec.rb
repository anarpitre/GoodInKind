require 'spec_helper'

describe "services/index.html.erb" do
  before(:each) do
    assign(:services, [
      stub_model(Service,
        :title => "Title",
        :description => "Description",
        :amount => 1.5,
        :booking_capacity => 1,
        :is_scheduled => false,
        :non_profit_id => 1,
        :group_number => 1,
        :non_profit_percentage => 1.5,
        :is_virtual => false,
        :is_public => false
      ),
      stub_model(Service,
        :title => "Title",
        :description => "Description",
        :amount => 1.5,
        :booking_capacity => 1,
        :is_scheduled => false,
        :non_profit_id => 1,
        :group_number => 1,
        :non_profit_percentage => 1.5,
        :is_virtual => false,
        :is_public => false
      )
    ])
  end

  it "renders a list of services" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
