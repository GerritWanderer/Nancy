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