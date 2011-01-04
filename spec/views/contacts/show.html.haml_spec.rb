require 'spec_helper'

describe "contacts/show.html.haml" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Salutation/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Firstname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lastname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Department/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fon/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mobile/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fax/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
