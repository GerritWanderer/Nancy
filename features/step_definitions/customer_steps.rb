# Generated by cucumber_scaffold - http://github.com/andyw8/cucumber_scaffold

Given /^a customer exists$/ do
  @customer = Customer.create!(valid_customer_attributes)
end

Then /^I should see the following customer:$/ do |expected_table|
  
  
  show_fields_css_query = 'body p b'
  
  
  actual_table = tableish(show_fields_css_query, lambda{|label| [label, label.next]})   
  actual = {}
  actual_table.each do |form_entry|
    attr_name = form_entry[0]
    attr_value = form_entry[1]
    actual[attr_name] = attr_value
  end
  assert_equal actual, expected_table.rows_hash
end

Then /^I should see the following customers:$/ do |expected_table|
  expected_table.diff!(tableish('table tr', 'td,th'))
end

Given /^the following customers:$/ do |table|
  hashes = replace_spaces_with_underscores_in_keys(table.hashes)
  @customers = Customer.create!(hashes)
end

Given /^the following customer:$/ do |table|
  hashes = replace_spaces_with_underscores_in_keys(table.rows_hash)
  @customer = Customer.create!(hashes)
end

def valid_customer_attributes
  # You may want to a factory for this
  { "name" => "customer", "shortname" => "shortname"}
end
