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
  user_ignore_keys = [:confirmed_at, :sign_in_count, :day_sequences]
  user.keys.each {|key|
    And %{I fill in "#{user_selector}#{key}" with "#{user[key.intern]}"} unless user_ignore_keys.index(key)
  }
  And %{I fill in "#{user_selector}password_confirmation" with "#{user[:password]}"}
end

When /^I fill in the user form with invalid values$/ do 
  user_selector = "user_"
  user = Factory.attributes_for(:user)
  user.keys.each {|key|
    And %{I fill in "#{user_selector}email" with ""} if key.to_s == "email"
  }
end

When /^I fill in the holiday form with valid values$/ do  
  day_sequence_selector = "day_sequence_"
  day_sequence = Factory.attributes_for(:holiday)
  day_sequence_ignore_keys = [:type_of_sequence, :verified, :user_id]
  day_sequence.keys.each {|key|
    And %{I fill in "#{day_sequence_selector}#{key}" with "#{day_sequence[key.intern]}"} unless day_sequence_ignore_keys.index(key)
  }
  And %{I fill in "#{day_sequence_selector}date_to" with "#{day_sequence[:date_from]}"}
end
When /^I fill in the holiday form with invalid values$/ do  
  day_sequence_selector = "day_sequence_"
  day_sequence = Factory.attributes_for(:holiday)
  day_sequence_ignore_keys = [:type_of_sequence, :verified, :user_id]
  day_sequence.keys.each {|key|
    And %{I fill in "#{day_sequence_selector}#{key}" with "#{day_sequence[key.intern]}"} if !day_sequence_ignore_keys.index(key) && key.to_s == "date_to"
  }
end

Then(/^I should see the holiday overview$/) do
  holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
  holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today)
  
  Then %{I should see "Holidays this year: #{holidays_current_year}" within "div#sequences div.holidays ul li:first-child"}
  Then %{I should see "Next Holiday: #{holiday_upcoming.first.date_from}" within "div#sequences div.holidays ul li:nth-child(2)"}
end

Then(/^I should see all holidays of the current year$/) do
  holidays = DaySequence.find_holidays_by_year(Date.today.year)
  counter = 0
  holidays.each do |holiday|
    counter+=1
    if holiday.date_to > holiday.date_from
      Then %{I should see "#{holiday.date_from} to #{holiday.date_to}" within "div#sequences div.holidays div.record dl dd:nth-child(#{counter+1})"}
    else
      Then %{I should see "#{holiday.date_from}" within "div#sequences div.holidays div.record dl dd:nth-child(#{counter+1})"}
    end
  end
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

Then(/^I should see all vacations and absences of the (\d+)(?:st|nd|rd|th) user$/) do |user|
  vacations = DaySequence.find_type_by_user_and_year(2, user.to_i, Date.today.year)
  absences = DaySequence.find_type_by_user_and_year(3, user.to_i, Date.today.year)
  
  counter = 0
  vacations.each do |vacation|
    counter+=1
    if vacation.date_to > vacation.date_from
      Then %{I should see "#{vacation.date_from} to #{vacation.date_to}" within "div#sequences div.user#active div.record dl dd:nth-child(#{counter+1})"}
    else
      Then %{I should see "#{vacation.date_from}" within "div#sequences div.user#active div.record dl dd:nth-child(#{counter+1})"}
    end
  end
  counter+=2
  absences.each do |absence|
    counter+=1
    if absence.date_to > absence.date_from
      Then %{I should see "#{absence.date_from} to #{absence.date_to}" within "div#sequences div.user#active div.record dl dd:nth-child(#{counter+1})"}
    else
      Then %{I should see "#{absence.date_from}" within "div#sequences div.user#active div.record dl dd:nth-child(#{counter+1})"}
    end
  end
end

When /^I follow "([^"]*)" in the (\d+)(?:st|nd|rd|th) user holidays row$/ do |link, pos|
  within("div#sequences div#users div.user:nth-child(#{pos.to_i}) ul.title li.actions") do
    click_link link
  end
end
