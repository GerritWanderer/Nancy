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
		
	Scenario: List holidays overview
		Given I sign up as user
		And a customer exist
		And 6 holidays exist
		When I go to the settings page
		And I follow "Managae Holidays"
		Then I should see the holiday overview
		
	Scenario: List users with vacation and holidays
		Given I sign up as user
		And a customer exist
		And 4 users exist
		When I go to the settings page
		And I follow "Managae Holidays"
		Then I should see all users with vacation and absence as overview
		
	Scenario: Create Holiday with valid values
		Given I sign up as user
		And a customer exist
		And 4 users exist
		When I go to the settings page
		And I follow "Managae Holidays"
		Then I should see all users with vacation and absence as overview