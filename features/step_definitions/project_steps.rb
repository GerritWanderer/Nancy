Then(/^I should see all projects(?: ordered "([^"]*)" "([^"]*)")?(?: with closed status "([^"]*)")?$/) do |field, order, status|
  if status == "true"
    projects = find_models("project", "closed: 1")
  elsif status == "false"
    projects = find_models("project", "closed: 0")
  else
    projects = find_models("project")
  end
  
  if order == "desc"
    projects = projects.sort_by { |h| h[field] }.reverse
  elsif order == "asc"
    projects = projects.sort_by { |h| h[field] }
  end
  
  counter = 0
  projects.each do |project|
    counter+=1
    Then %{I should see "#{project.id}" within "div.project:nth-child(#{counter+3}) ul.title li:first-child"}
    Then %{I should see "#{project.title}" within "div.project:nth-child(#{counter+3}) ul.title li:nth-child(2)"}
    Then %{I should see "#{project.customer.name}" within "div.project:nth-child(#{counter+3}) ul.title li:nth-child(3)"}
    Then %{I should see "#{project.created_at.strftime("%d-%m-%Y")}" within "div.project:nth-child(#{counter+3}) ul.title li:nth-child(4)"}
  end
end

When /^I click "([^"]*)" in the (\d+)(?:st|nd|rd|th) project row$/ do |link, pos|
  within("div.project:nth-child(#{pos.to_i+3}) ul.title li.actions") do
    click_link link
  end
end

Then(/^I should see the (\d+)(?:st|nd|rd|th) project active$/) do |row|
  project = find_model!("project", "id: #{row}")
  Then %{I should see "#{project.id}" within "div.project ul.title#active li:first-child"}
  Then %{I should see "#{project.title}" within "div.project ul.title#active li:nth-child(2)"}
  Then %{I should see "#{project.customer.name}" within "div.project ul.title#active li:nth-child(3)"}
  Then %{I should see "#{project.created_at.strftime("%d-%m-%Y")}" within "div.project ul.title#active li:nth-child(4)"}
end


When /^I fill in the project form with valid values$/ do  
  project_selector = "project_"
  project = Factory.attributes_for(:project)
  project_ignore_keys = [:contact_id, :customer_id, :closed, :type]
  project.keys.each {|key|
    And %{I fill in "#{project_selector}#{key}" with "#{project[key.intern]}"} unless project_ignore_keys.index(key)
  }
end

When /^I fill in the project form with invalid values$/ do  
  project_selector = "project_"
  project = Factory.attributes_for(:project)
  project_ignore_keys = [:contact_id, :customer_id, :closed, :type, :description]
  project.keys.each {|key|
    And %{I fill in "#{project_selector}#{key}" with ""} unless project_ignore_keys.index(key)
  }
end

Then(/^I should see all works for the (\d+)(?:st|nd|rd|th) project$/) do |project|
  works = find_models("work", "project_id: #{project}")
  works = works.sort_by { |w| w["started_at"] }
  counter = 0
  works.each do |work|
    counter+=1
    Then %{I should see "#{work.started_at.strftime('%Y-%m-%d')} #{work.started_at.strftime('%H:%M')} to #{work.ended_at.strftime('%H:%M')} #{User.find(work.user_id).firstname} #{User.find(work.user_id).lastname}" within "div#works ul.record:nth-child(#{counter}) li:first-child"}
    Then %{I should see "#{work.description}" within "div#works ul.record:nth-child(#{counter}) li:nth-child(2)"}
    Then %{I should see "#{work.duration} min." within "div#works ul.record:nth-child(#{counter}) li:nth-child(3)"}
  end
end