require 'spec_helper'

describe "works/edit.html.haml" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :duration => 1,
      :description => "MyText",
      :project => nil
    ))
  end

  it "renders the edit work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_path(@work), :method => "post" do
      assert_select "input#work_duration", :name => "work[duration]"
      assert_select "textarea#work_description", :name => "work[description]"
      assert_select "input#work_project", :name => "work[project]"
    end
  end
end
