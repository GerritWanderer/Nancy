Then(/^I should see the "([^"]*)" calendarweek$/) do |pos|
  if pos == "next"
    day = Date.today.-(Date.today.cwday - 1).+7
  elsif pos == "previous"
    day = Date.today.-(Date.today.cwday - 1).-7
  else
    day = Date.today.-(Date.today.cwday - 1)
  end

  counter = 0
  7.times do
    counter+=1
    Then %{I should see "#{day.strftime("%a. %d.%m.")}" within "ul#calendarWeek li:nth-child(#{counter})"}
    day = day.+(1)
  end
end

Then(/^I should see the (\d+)(?:st|nd|rd|th) weekday active$/) do |day|
  day = Date.today.-(Date.today.cwday - 1).+(day.to_i-1)
  Then %{I should see "#{day.strftime("%a. %d.%m.")}" within "ul#calendarWeek li#active"}
end

Then(/^I should see all my work of the current weekday$/) do
  works = find_models("work")
  works = works.sort_by { |w| w["started_at"] }
  Rails.logger.info works
  counter = 0
  works.each do |work|
    counter+=1
    Then %{I should see "#{work.started_at.strftime('%H:%M')} to #{work.ended_at.strftime('%H:%M')}" within "div#works ul.record:nth-child(#{counter}) li:first-child"}
    Then %{I should see "#{work.duration}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(2)"}
    Then %{I should see "#{work.project.title}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(3)"}
    Then %{I should see "#{work.project.customer.name}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(4)"}
    Then %{I should see "#{work.description}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(5)"}
  end
end

When /^I click "([^"]*)" in the (\d+)(?:st|nd|rd|th) work row$/ do |link, pos|
  within("div#works ul.record:nth-child(#{pos.to_i}) li.actions") do
    click_link link
  end
end
When /^I select the (\d+)(?:st|nd|rd|th) customer$/ do |pos|
  customer_name = Customer.with_active_projects.joins(:projects).uniq[pos.to_i].name
  When %{I select "#{customer_name}" from "customer_id"}
end
Then /^the (\d+)(?:st|nd|rd|th) customer is selected$/ do |pos|
  customers = Customer.with_active_projects.joins(:projects).uniq
  customer_name = customers[pos.to_i].name
  Then %{the "customer_id" field should contain "#{customer_name}"}
end

When /^I fill in the work form with valid values$/ do 
  work_selector = "work_"
	start_time = Time.parse("#{Date.today.strftime("%Y-%m-%d")} #{rand(24)}:#{rand(60)}")
	end_time = start_time.+(15*60)
  work = Factory.attributes_for(:work)
  And %{I fill in "work_description" with "#{work[:description]}"}
  And %{I fill in "work_started_at" with "#{start_time.strftime('%H:%M')}"}
  And %{I fill in "work_end" with "#{end_time.strftime('%H:%M')}"}
end
When /^I submit the work form with values from "([^"]*)" to "([^"]*)"$/ do |start_time, end_time|
  work_selector = "work_"
  work = Factory.attributes_for(:work)
  And %{I fill in "work_description" with "#{work[:description]}"}
  And %{I fill in "work_started_at" with "#{start_time}"}
  And %{I fill in "work_end" with "#{end_time}"}
  And %{I press "Save"}
end

When /^I fill in the work form with invalid values$/ do 
  work_selector = "work_"
  work = Factory.attributes_for(:work)
  work_ignore_keys = [:start_datetime, :end_datetime, :user_id, :project_id, :duration, :description]
  work.keys.each {|key|
    And %{I fill in "#{work_selector}#{key}" with "#{work[key.intern]}"} unless work_ignore_keys.index(key)
  }
end