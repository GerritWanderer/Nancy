require 'spec_helper'

describe "customers/index.html.haml" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :name => "Name",
        :shortname => "Shortname",
        :website => "Website"
      ),
      stub_model(Customer,
        :name => "Name",
        :shortname => "Shortname",
        :website => "Website"
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Shortname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Website".to_s, :count => 2
  end
end
