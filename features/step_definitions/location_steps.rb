Then(/^I should see the (\d+)(?:st|nd|rd|th) location from (\d+)(?:st|nd|rd|th) customer$/) do |pos, customer|
	locations = find_models("location", "customer_id: #{customer}")
	location = locations[pos.to_i - 1]
	Then %{I should see "#{location.name}" within "div.customer div.location ul.record li:first-child"}
	Then %{I should see "#{location.street} #{location.zip} #{location.city}" within "div.customer div.location ul.record li:nth-child(2)"}
	Then %{I should see "Fon: #{location.fon} Fax: #{location.fax}" within "div.customer div.location ul.record li:nth-child(3)"}
end

When /^I fill in the location form with valid values$/ do	
	location_selector = "location_"
	location = Factory.attributes_for(:location)
	location.keys.each {|key|
		And %{I fill in "#{location_selector}#{key}" with "#{location[key.intern]}"} if key.to_s != "contacts"
	}
end

When /^I fill in the location form with invalid values$/ do	
	location_selector = "location_"
	location = Factory.attributes_for(:location)
	location.keys.each {|key|
		And %{I fill in "#{location_selector}#{key}" with ""} if key.to_s != "contacts" && key.to_s != "name"
	}
end