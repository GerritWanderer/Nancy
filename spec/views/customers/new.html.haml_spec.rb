require 'spec_helper'

describe "customers/new.html.haml" do
  before(:each) do
    assign(:customer, stub_model(Customer,
      :name => "MyString",
      :shortname => "MyString",
      :website => "MyString"
    ).as_new_record)
  end

  it "renders new customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customers_path, :method => "post" do
      assert_select "input#customer_name", :name => "customer[name]"
      assert_select "input#customer_shortname", :name => "customer[shortname]"
      assert_select "input#customer_website", :name => "customer[website]"
    end
  end
end
