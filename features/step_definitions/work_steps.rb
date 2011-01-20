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
		Then %{I should see "#{day.strftime("%a. %d.%m.")}" within "ul#calendar li:nth-child(#{counter})"}
		day = day.+(1)
	end
end

Then(/^I should see the (\d+)(?:st|nd|rd|th) weekday active$/) do |day|
	day = Date.today.-(Date.today.cwday - 1).+(day.to_i-1)
  Then %{I should see "#{day.strftime("%a. %d.%m.")}" within "ul#calendar li#active"}
end

Then(/^I should see all my work of the current weekday$/) do
	works = find_models("work")
	Rails.logger.info works
	counter = 0
  works.each do |work|
		counter+=1
		Then %{I should see "#{work.start.strftime('%H:%M')} to #{work.end.strftime('%H:%M')}" within "div#works ul.record:nth-child(#{counter}) li:first-child"}
		Then %{I should see "#{work.duration}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(2)"}
		Then %{I should see "#{work.project.title}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(3)"}
		Then %{I should see "#{work.project.customer.name}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(4)"}
		Then %{I should see "#{work.description}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(5)"}
	end
end

When /^I fill in the work form with valid values$/ do	
	work_selector = "work_"
	work = Factory.attributes_for(:work)
	work.keys.each {|key|
		And %{I fill in "#{work_selector}#{key}" with "#{work[key.intern]}"} if key.to_s != "user_id" && key.to_s != "project_id" && key.to_s != "duration"
	}
end

When /^I fill in the work form with invalid values$/ do	
	work_selector = "work_"
	work = Factory.attributes_for(:work)
	work.keys.each {|key|
		And %{I fill in "#{work_selector}#{key}" with "#{work[key.intern]}"} if key.to_s != "user_id" && key.to_s != "project_id" && key.to_s != "start" && key.to_s != "duration" && key.to_s != "description"
	}
end