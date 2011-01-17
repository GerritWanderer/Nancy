require 'spec_helper'

describe "works/index.html.haml" do
  before(:each) do
    assign(:works, [
      stub_model(Work,
        :duration => 1,
        :description => "MyText",
        :project => nil
      ),
      stub_model(Work,
        :duration => 1,
        :description => "MyText",
        :project => nil
      )
    ])
  end

  it "renders a list of works" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
