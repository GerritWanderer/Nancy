require 'spec_helper'

describe "customers/show.html.haml" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :name => "Name",
      :shortname => "Shortname",
      :website => "Website"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Shortname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Website/)
  end
end
