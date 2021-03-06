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
    And I follow "Edit" in the 2nd user row
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
    And I follow "Edit" in the 2nd user row
    #Then I should be on the edit user page
    When I fill in the user form with invalid values
    And I press "Save User"
    Then I should see "error prohibited this user from being saved:"
    
  Scenario: Create a User with valid values
    Given I sign up as user
    And a customer exist
    When I go to the settings page
    And I fill in the user form with valid values
    And I press "Save User"
    #Then I should see User was created
    
  Scenario: Create a User with valid values
    Given I sign up as user
    And a customer exist
    When I go to the settings page
    And I fill in the user form with invalid values
    And I press "Save User"
    Then I should see "errors prohibited this user from being saved:" 
    
  Scenario: Delete a user
    Given I sign up as user
    And 4 users exist
    And a customer exist
    When I go to the settings page
    And I follow "Delete" in the 3rd user row
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
    And I follow "Container-open" within "div#days div.holidays ul.title li.actions"
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
    
  Scenario: Create Holiday with valid values
    Given I sign up as user
    And a customer exist
    And 4 users exist
    When I go to the settings page
    And I follow "Managae Holidays"
    And I fill in the holiday form with valid values
    And I press "Save Sequence"
    Then I should see "Holidays this year: 1"
    
  Scenario: Attemp to create a holiday with invalid values
    Given I sign up as user
    And a customer exist
    And 4 users exist
    When I go to the settings page
    And I follow "Managae Holidays"
    And I fill in the holiday form with invalid values
    And I press "Save Sequence"
    Then I should see "errors prohibited this day from being saved:"
  
  Scenario: Delete a holiday, vacation and absence
    Given I sign up as user
    And a customer exist
    And a day exist with type_of_day: 2, user_id: 1, date_from: "2011-01-01"
    And a day exist with type_of_day: 2, user_id: 1, date_from: "2011-01-02"
    And a day exist with type_of_day: 3, user_id: 1, date_from: "2011-02-04"
    And a day exist with type_of_day: 3, user_id: 1, date_from: "2011-02-03"
    When I go to the settings page
    And I follow "Managae Holidays"
    And I follow "Container-open" in the 1st user holidays row
    And I follow "Delete" within "div.user#active div.record dl dd:nth-child(3)"
    Then I should not see "2011-01-02" within "div.user#active div.record"
    When I follow "Delete" within "div.user#active div.record dl dd:nth-child(5)"
    Then I should not see "2011-01-04" within "div.user#active div.record"