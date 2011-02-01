Feature: Manage work
	In order to manage work of a project
	As a user
	I want to perform serveral work operations

	Scenario:	Switch days of current calendarweek
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		When I go to the works page
		Then I should see the "current" calendarweek
		When I follow "Mon." within "ul#calendar li:first-child"
		Then I should see the 1st weekday active
		When I follow "Tue." within "ul#calendar li:nth-child(2)"
		Then I should see the 2nd weekday active
		When I follow "Wed." within "ul#calendar li:nth-child(3)"
		Then I should see the 3rd weekday active
		When I follow "Thu." within "ul#calendar li:nth-child(4)"
		Then I should see the 4th weekday active
		When I follow "Fri." within "ul#calendar li:nth-child(5)"
		Then I should see the 5th weekday active
		When I follow "Sat." within "ul#calendar li:nth-child(6)"
		Then I should see the 6th weekday active
		When I follow "Sun." within "ul#calendar li:nth-child(7)"
		Then I should see the 7th weekday active
	
	Scenario:	Switch calendarweeks of the current year
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		When I go to the works page
		Then I should see the "current" calendarweek
		When I follow "Calendarweek-next" within "ul#calendar li#calendarWeek"
		Then I should see the "next" calendarweek
		When I follow "Calendarweek-prev" within "ul#calendar li#calendarWeek"
		And I follow "Calendarweek-prev" within "ul#calendar li#calendarWeek"
		Then I should see the "previous" calendarweek
	
	@test
	Scenario: List my work of the current day
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		And 6 works exist
		When I go to the works page
		Then show me the page
		Then I should see all my work of the current weekday
		#improve
		
	@wip
	Scenario: Switch Customer within form
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		When I go to the works page
		And I select the 2nd customer
		Then the 2nd customer is selected 
		
	Scenario: Create a valid Work
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		And 6 works exist
		When I go to the works page
		When I fill in the work form with valid values
		And I press "Save"
		Then I should see "Work was successfully created."
		#improve
		
	Scenario: Attemp to create a new Work with invalid fields
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		And 6 works exist
		When I go to the works page
		When I fill in the work form with invalid values
		And I press "Save"
		Then I should see "errors prohibited this work from being saved:"
		
	Scenario: Delete a work
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		And 6 works exist
		When I go to the works page
		And I click "Delete" in the 2nd work row
		Then work should not exist with id: 2
		And I should be on the works page