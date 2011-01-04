require 'spec_helper'

describe "contacts/index.html.haml" do
  before(:each) do
    assign(:contacts, [
      stub_model(Contact,
        :salutation => "Salutation",
        :title => "Title",
        :firstname => "Firstname",
        :lastname => "Lastname",
        :department => "Department",
        :email => "Email",
        :fon => "Fon",
        :mobile => "Mobile",
        :fax => "Fax",
        :location => nil
      ),
      stub_model(Contact,
        :salutation => "Salutation",
        :title => "Title",
        :firstname => "Firstname",
        :lastname => "Lastname",
        :department => "Department",
        :email => "Email",
        :fon => "Fon",
        :mobile => "Mobile",
        :fax => "Fax",
        :location => nil
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Salutation".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Department".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fon".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
