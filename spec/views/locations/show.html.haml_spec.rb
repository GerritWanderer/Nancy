require 'spec_helper'

describe "locations/show.html.haml" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :name => "Name",
      :street => "Street",
      :zip => 1,
      :city => "City",
      :fon => "Fon",
      :fax => "Fax",
      :customer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Street/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fon/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fax/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
