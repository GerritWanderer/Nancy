Then(/^I should see all users in nancy$/) do
	users = find_models("user")
	
	counter = 0
  users.each do |user|
		counter+=1
		Then %{I should see "#{user.firstname} #{user.lastname}" within "div#users div.user:nth-child(#{counter+1}) ul.title li:first-child"}
		Then %{I should see "#{user.email}" within "div#users div.user:nth-child(#{counter+1}) ul.title li:nth-child(2)"}
		Then %{I should see "#{user.hours} / #{user.holidays}" within "div#users div.user:nth-child(#{counter+1}) ul.title li:nth-child(3)"}
	end
end

When /^I follow "([^"]*)" in the (\d+)(?:st|nd|rd|th) user row$/ do |link, pos|
	within("div#users div.user:nth-child(#{pos.to_i+1}) ul.title li.actions") do
    click_link link
  end
end

When /^I fill in the user form with valid values$/ do	
	user_selector = "user_"
	user = Factory.attributes_for(:user)
	user_ignore_keys = [:confirmed_at, :sign_in_count, :password, :day_sequences]
	user.keys.each {|key|
		And %{I fill in "#{user_selector}#{key}" with "#{user[key.intern]}"} unless user_ignore_keys.index(key)
	}
end

When /^I fill in the user form with invalid values$/ do	
	user_selector = "user_"
	user = Factory.attributes_for(:user)
	user.keys.each {|key|
		And %{I fill in "#{user_selector}#{key}" with ""} if key.to_s == "email"
	}
end

Then(/^I should see the holiday overview$/) do
	holidays_current_year = DaySequence.find_holidays_by_year(Date.today.year)
	holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today)
	
	Then %{I should see "Holidays this year: #{holidays_current_year}" within "div#sequences div#holidays ul li:first-child"}
	Then %{I should see "Next Holiday: #{holiday_upcoming.first.date_from}" within "div#sequences div#holidays ul li:nth-child(2)"}
end

Then(/^I should see all users with vacation and absence as overview$/) do
	users = find_models("user")
	
	counter = 0
  users.each do |user|
		counter+=1
		Then %{I should see "#{user.firstname} #{user.lastname}" within "div#users div.user:nth-child(#{counter}) ul.title li:first-child"}
		Then %{I should see "Vacation available: #{user.holidays}" within "div#users div.user:nth-child(#{counter}) ul.title li:nth-child(2)"}
		Then %{I should see "Vacation taken: #{DaySequence.find_type_by_user_and_year(2, user.id, Date.today.year).count}" within "div#users div.user:nth-child(#{counter}) ul.title li:nth-child(3)"}
		Then %{I should see "Days of Absence: #{DaySequence.find_type_by_user_and_year(3, user.id, Date.today.year).count}" within "div#users div.user:nth-child(#{counter}) ul.title li:nth-child(4)"}
	end
end