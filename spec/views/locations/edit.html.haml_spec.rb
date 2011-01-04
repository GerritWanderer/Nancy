require 'spec_helper'

describe "locations/edit.html.haml" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :name => "MyString",
      :street => "MyString",
      :zip => 1,
      :city => "MyString",
      :fon => "MyString",
      :fax => "MyString",
      :customer => nil
    ))
  end

  it "renders the edit location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => location_path(@location), :method => "post" do
      assert_select "input#location_name", :name => "location[name]"
      assert_select "input#location_street", :name => "location[street]"
      assert_select "input#location_zip", :name => "location[zip]"
      assert_select "input#location_city", :name => "location[city]"
      assert_select "input#location_fon", :name => "location[fon]"
      assert_select "input#location_fax", :name => "location[fax]"
      assert_select "input#location_customer", :name => "location[customer]"
    end
  end
end
