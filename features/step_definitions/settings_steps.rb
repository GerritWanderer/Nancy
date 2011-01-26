Then(/^I should see all users in nancy$/) do
	users = find_models("user")
	
	counter = 0
  users.each do |user|
		counter+=1
		Then %{I should see "#{user.firstname} #{user.lastname} #{user.email}" within "div#users div.records ul.record:nth-child(#{counter}) li:first-child"}
		Then %{I should see "#{user.holidays}" within "div#users div.records ul.record:nth-child(#{counter}) li:nth-child(2)"}
		Then %{I should see "#{user.hours}" within "div#users div.records ul.record:nth-child(#{counter}) li:nth-child(3)"}
	end
end

When /^I follow "([^"]*)" in the (\d+)(?:st|nd|rd|th) user row$/ do |link, pos|
	within("div#users div.records ul.record:nth-child(#{pos.to_i}) li.actions") do
    click_link link
  end
end

When /^I fill in the user form with valid values$/ do	
	user_selector = "user_"
	user = Factory.attributes_for(:user)
	user.keys.each {|key|
		And %{I fill in "#{user_selector}#{key}" with "#{user[key.intern]}"} if key.to_s != "confirmed_at" && key.to_s != "sign_in_count"  && key.to_s != "password"
	}
end

When /^I fill in the user form with invalid values$/ do	
	user_selector = "user_"
	user = Factory.attributes_for(:user)
	user.keys.each {|key|
		And %{I fill in "#{user_selector}#{key}" with ""} if key.to_s == "email"
	}
end