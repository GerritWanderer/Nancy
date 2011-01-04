require 'spec_helper'

describe "contacts/edit.html.haml" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :salutation => "MyString",
      :title => "MyString",
      :firstname => "MyString",
      :lastname => "MyString",
      :department => "MyString",
      :email => "MyString",
      :fon => "MyString",
      :mobile => "MyString",
      :fax => "MyString",
      :location => nil
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contact_path(@contact), :method => "post" do
      assert_select "input#contact_salutation", :name => "contact[salutation]"
      assert_select "input#contact_title", :name => "contact[title]"
      assert_select "input#contact_firstname", :name => "contact[firstname]"
      assert_select "input#contact_lastname", :name => "contact[lastname]"
      assert_select "input#contact_department", :name => "contact[department]"
      assert_select "input#contact_email", :name => "contact[email]"
      assert_select "input#contact_fon", :name => "contact[fon]"
      assert_select "input#contact_mobile", :name => "contact[mobile]"
      assert_select "input#contact_fax", :name => "contact[fax]"
      assert_select "input#contact_location", :name => "contact[location]"
    end
  end
end
