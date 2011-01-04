require 'spec_helper'

describe "locations/index.html.haml" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :name => "Name",
        :street => "Street",
        :zip => 1,
        :city => "City",
        :fon => "Fon",
        :fax => "Fax",
        :customer => nil
      ),
      stub_model(Location,
        :name => "Name",
        :street => "Street",
        :zip => 1,
        :city => "City",
        :fon => "Fon",
        :fax => "Fax",
        :customer => nil
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fon".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
