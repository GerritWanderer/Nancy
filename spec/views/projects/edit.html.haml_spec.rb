require 'spec_helper'

describe "projects/edit.html.haml" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :title => "MyString",
      :description => "MyText",
      :discount => 1.5,
      :budget => 1.5,
      :type => 1,
      :closed => false,
      :customer => nil,
      :contact => nil
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_path(@project), :method => "post" do
      assert_select "input#project_title", :name => "project[title]"
      assert_select "textarea#project_description", :name => "project[description]"
      assert_select "input#project_discount", :name => "project[discount]"
      assert_select "input#project_budget", :name => "project[budget]"
      assert_select "input#project_type", :name => "project[type]"
      assert_select "input#project_closed", :name => "project[closed]"
      assert_select "input#project_customer", :name => "project[customer]"
      assert_select "input#project_contact", :name => "project[contact]"
    end
  end
end
