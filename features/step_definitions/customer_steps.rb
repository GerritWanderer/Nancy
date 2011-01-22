Then(/^I should see all customers(?: ordered "([^"]*)" "([^"]*)")?$/) do |field, order|
	customers = find_models("customer")
	if order == "desc"
		customers = customers.sort_by { |h| h[field] }.reverse
	elsif order == "asc"
		customers = customers.sort_by { |h| h[field] }
	end
	
	counter = 0
  customers.each do |customer|
		counter+=1
		Then %{I should see "#{customer.name}" within "div.customer:nth-child(#{counter+2}) ul.title li:first-child"}
		Then %{I should see "#{customer.shortname}" within "div.customer:nth-child(#{counter+2}) ul.title li:nth-child(2)"}
	end
end

When /^I click "([^"]*)" in the (\d+)(?:st|nd|rd|th) customer row$/ do |link, pos|
  within("div.customer:nth-child(#{pos.to_i+2}) ul.title li.actions") do
    click_link link
  end
end

Then(/^I should see the (\d+)(?:st|nd|rd|th) customer active$/) do |row|
	customer = find_model!("customer", "id: #{row}")
	Then %{I should see "#{customer.name}" within "div.customer ul.title#active li:first-child"}
	Then %{I should see "#{customer.shortname}" within "div.customer ul.title#active li:nth-child(2)"}
end

When /^I fill in the customer form with valid values$/ do	
	customer_selector = "customer_"
	customer = Factory.attributes_for(:customer)
	customer.keys.each {|key|
		And %{I fill in "#{customer_selector}#{key}" with "#{customer[key.intern]}"} if key.to_s != "locations"
	}
	
	location_selector = "customer_locations_attributes_0_"
	location = Factory.attributes_for(:location)
	location.keys.each {|key|
		And %{I fill in "#{location_selector}#{key}" with "#{location[key.intern]}"} if key.to_s != "contacts"
	}

	contact_selector = "customer_locations_attributes_0_contacts_attributes_0_"
	contact = Factory.attributes_for(:contact)
	contact.keys.each {|key|
		And %{I fill in "#{contact_selector}#{key}" with "#{contact[key.intern]}"} if key.to_s != "salutation"
	}
end

When /^I fill in the customer form with invalid values$/ do	
	customer_selector = "customer_"
	customer = Factory.attributes_for(:customer)
	customer.keys.each {|key|
		And %{I fill in "#{customer_selector}#{key}" with "#{customer[key.intern]}"} if key.to_s != "locations" && key.to_s != "shortname"
	}
	
	location_selector = "customer_locations_attributes_0_"
	location = Factory.attributes_for(:location)
	location.keys.each {|key|
		And %{I fill in "#{location_selector}#{key}" with "#{location[key.intern]}"} if key.to_s != "contacts"
	}

	contact_selector = "customer_locations_attributes_0_contacts_attributes_0_"
	contact = Factory.attributes_for(:contact)
	contact.keys.each {|key|
		And %{I fill in "#{contact_selector}#{key}" with "#{contact[key.intern]}"} if key.to_s != "salutation"
	}
end