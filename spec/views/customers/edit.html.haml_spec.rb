require 'spec_helper'

describe "customers/edit.html.haml" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :name => "MyString",
      :shortname => "MyString",
      :website => "MyString"
    ))
  end

  it "renders the edit customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customer_path(@customer), :method => "post" do
      assert_select "input#customer_name", :name => "customer[name]"
      assert_select "input#customer_shortname", :name => "customer[shortname]"
      assert_select "input#customer_website", :name => "customer[website]"
    end
  end
end
