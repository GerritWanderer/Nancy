require 'spec_helper'

describe "works/show.html.haml" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :duration => 1,
      :description => "MyText",
      :project => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
