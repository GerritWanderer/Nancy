Then(/^I should see all the contacts from (\d+)(?:st|nd|rd|th) location and (\d+)(?:st|nd|rd|th) customer$/) do |location, customer|
  locations = find_models("location", "customer_id: #{customer}")
  location = locations[location.to_i - 1]
  contacts = find_models("contact", "location_id: #{location.id}")
  
  counter = 0
  contacts.each do |contact|
    counter+=1
    Then %{I should see "#{contact.salutation} #{contact.title} #{contact.firstname} #{contact.lastname}" within "div.customer div.contacts ul.record:nth-child(#{counter+1}) li:first-child"}
    Then %{I should see "#{contact.department}" within "div.customer div.contacts ul.record:nth-child(#{counter+1}) li:nth-child(2)"}
    Then %{I should see "Fon: #{contact.fon}" within "div.customer div.contacts ul.record:nth-child(#{counter+1}) li:nth-child(3) span:first-child"}
    Then %{I should see "Fax: #{contact.fax}" within "div.customer div.contacts ul.record:nth-child(#{counter+1}) li:nth-child(3) span:nth-child(2)"}
    Then %{I should see "Mobile: #{contact.mobile}" within "div.customer div.contacts ul.record:nth-child(#{counter+1}) li:nth-child(3) span:nth-child(3)"}
  end
end

When /^I fill in the contact form with valid values$/ do  
  contact_selector = "contact_"
  contact = Factory.attributes_for(:contact)
  contact_ignore_keys = [:salutation]
  contact.keys.each {|key|
    And %{I fill in "#{contact_selector}#{key}" with "#{contact[key.intern]}"} unless contact_ignore_keys.index(key)
  }
end

When /^I fill in the contact form with invalid values$/ do  
  contact_selector = "contact_"
  contact = Factory.attributes_for(:contact)
  contact_ignore_keys = [:salutation]
  contact.keys.each {|key|
    And %{I fill in "#{contact_selector}#{key}" with ""} unless contact_ignore_keys.index(key)
  }
end