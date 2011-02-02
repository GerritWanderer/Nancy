Feature: Manage settings
	In order to manage settings of nancy
	As a admin
	I want to perform serveral operations on users and settings
	
	Scenario: List all users
		Given I sign up as user
		And 4 users exist
		And a customer exist
		When I go to the settings page
		Then I should see all users in nancy
		
	Scenario: Update a user with valid fields
		Given I sign up as user
		And 4 users exist
		And a customer exist
		When I go to the settings page
		And I follow "E" in the 2nd user row
		#Then I should be on the edit user page
		When I fill in the user form with valid values
		And I press "Save User"
		And I should be on the settings page
		Then I should see "User was successfully updated."
		And I should see all users in nancy
		
	Scenario: Attemp to update a user with invalid fields
		Given I sign up as user
		And 4 users exist
		And a customer exist
		When I go to the settings page
		And I follow "E" in the 2nd user row
		#Then I should be on the edit user page
		When I fill in the user form with invalid values
		And I press "Save User"
		Then I should see "error prohibited this user from being saved:"
		
	Scenario: Delete a user
		Given I sign up as user
		And 4 users exist
		And a customer exist
		When I go to the settings page
		And I follow "D" in the 3rd user row
		#Then I should be on the edit user page
		Then user should not exist with id: 3
		And I should see "User was successfully deleted."
		
	Scenario: List holiday overview
		Given I sign up as user
		And a customer exist
		And 6 holidays exist
		When I go to the settings page
		And I follow "Managae Holidays"
		Then I should see the holiday overview
	
	Scenario: Show all holidays of the current year
		Given I sign up as user
		And a customer exist
		And 6 holidays exist
		When I go to the settings page
		And I follow "Managae Holidays"
		And I follow "Container-open" within "div#sequences div.holidays ul.title li.actions"
		Then I should see all holidays of the current year
		#And i should be on the holidays detail page
		
	Scenario: List users with vacation and holidays
		Given I sign up as user
		And a customer exist
		And 4 users exist
		When I go to the settings page
		And I follow "Managae Holidays"
		Then I should see all users with vacation and absence as overview
		
	Scenario: Show all vacations and absences of a User
		Given I sign up as user
		And a customer exist
		And 4 users exist
		When I go to the settings page
		And I follow "Managae Holidays"
		And I follow "Container-open" in the 2nd user holidays row
		Then I should see all vacations and absences of the 2nd user
		
	@wip	
	Scenario: Create Holiday with valid values
		
	@wip
	Scenario: Attemp to create a holiday with invalid values
	
	Scenario: Delete a holiday, vacation and absence
		Given I sign up as user
		And a customer exist
		And a day_sequence exist with type_of_sequence: 2, user_id: 1, date_from: "2011-01-01", date_to: "2011-01-02"
		And a day_sequence exist with type_of_sequence: 2, user_id: 1, date_from: "2011-01-03", date_to: "2011-01-03"
		And a day_sequence exist with type_of_sequence: 3, user_id: 1, date_from: "2011-01-04", date_to: "2011-01-04"
		And a day_sequence exist with type_of_sequence: 3, user_id: 1, date_from: "2011-01-05", date_to: "2011-01-06"
		When I go to the settings page
		And I follow "Managae Holidays"
		And I follow "Container-open" in the 1st user holidays row
		And I follow "Delete" within "div.user#active div.record dl dd:nth-child(3)"
		Then I should not see "2011-01-03" within "div.user#active div.record"
		When I follow "Delete" within "div.user#active div.record dl dd:nth-child(5)"
		Then I should not see "2011-01-05 to 2011-01-06" within "div.user#active div.record"