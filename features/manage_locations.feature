Feature: Manage locations
  In order to manage locations of a customer
  As a user
  I want to perform serveral location operations
  
	
  Scenario: View a customers location
    Given I sign up as user
		And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
		Then I should see the 1st location from 2nd customer
  
  Scenario: Skip locations
	  Given I sign up as user
		And 3 customers exist
	  When I go to the customers page
	  And I click "Container-open" in the 2nd customer row
		Then I should see the 1st location from 2nd customer
		When I follow "Next" within "div.customer div.location h2"
		Then I should see the 2nd location from 2nd customer
		When I follow "Next" within "div.customer div.location h2"
		Then I should see the 3rd location from 2nd customer
		When I follow "Previous" within "div.customer div.location h2"
		Then I should see the 2nd location from 2nd customer
		When I follow "Previous" within "div.customer div.location h2"
		Then I should see the 1st location from 2nd customer
  
	Scenario: Create a valid location within a customer
		Given I sign up as user
		And 3 customers exist
	  When I go to the customers page
	  And I click "Container-open" in the 2nd customer row
		And I follow "Location-create" within "div.customer div.location span.actions"
		#Then I should be on the create location page
		When I fill in the location form with valid values
		And I press "Save Location"
		Then I should see "Location was successfully created."
		#And I should be on the page for that customer
		And I should see the 4th location from 2nd customer

	Scenario: Attempt to create a new location with invalid input within a customer
		Given I sign up as user
		And 3 customers exist
	  When I go to the customers page
	  And I click "Container-open" in the 2nd customer row
		And I follow "Location-create" within "div.customer div.location span.actions"
		#Then I should be on the create location page
		When I fill in the location form with invalid values
		And I press "Save Location"
		Then I should see "errors prohibited this contact from being saved:"
		#And I should be on the page for that customer

	Scenario: Update a localtion from a customer with valid fields
		Given I sign up as user
		And 3 customers exist
		When I go to the customers page
		And I click "Container-open" in the 2nd customer row
		And I follow "Edit" within "div.customer div.location span.actions"
		#Then I should be on the create location page
		And I fill in the customer form with valid values
		And I press "Save Location"
		Then I should see "Location was successfully updated."
		#And I should be on the page for that customer

	Scenario: Attempt to update a new location with invalid input within a customer
		Given I sign up as user
		And 3 customers exist
		When I go to the customers page
		And I click "Container-open" in the 2nd customer row
		And I follow "Edit" within "div.customer div.location span.actions"
		#Then I should be on the create location page
		And I fill in the location form with invalid values
		And I press "Save Location"
		Then I should see "errors prohibited this contact from being saved:"
		#And I should be on the page for that customer

	Scenario: Delete a customer
		Given I sign up as user
		And 3 customers exist
		When I go to the customers page
		And I click "Container-open" in the 1st customer row
		And I follow "Next" within "div.customer div.location h2"
		And I follow "Delete" within "div.customer div.location span.actions"
		Then location should not exist with id: 2
		And I should see the 1st location from 1st customer