Feature: Manage contacts
  In order to manage contacts of a location
  As a user
  I want to perform serveral contacts operations
  
  Scenario: View all contacts of different locations within a customer
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    Then I should see all the contacts from 1st location and 2nd customer
    When I follow "Next" within "div.customer div.location h2"
    Then I should see all the contacts from 2nd location and 2nd customer
    When I follow "Next" within "div.customer div.location h2"
    Then I should see all the contacts from 3rd location and 2nd customer

  Scenario: Create a valid contact within a location and a customer
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    And I follow "Next" within "div.customer div.location h2"
    And I follow "Contact-create" within "div.customer div.contacts span.actions"
    # Then I should be on the customer's location's contact's create page
    When I fill in the contact form with valid values
    And I press "Save Contact"
    Then I should see "Contact was successfully created."
    And I should see all the contacts from 2nd location and 2nd customer
    
  Scenario: Attempt to create a new location with invalid input within a customer
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    And I follow "Next" within "div.customer div.location h2"
    And I follow "Contact-create" within "div.customer div.contacts span.actions"
    # Then I should be on the customer's location's contact's create page
    When I fill in the contact form with invalid values
    And I press "Save Contact"
    Then I should see "errors prohibited this contact from being saved:"

  Scenario: Update a contact from a loaction with valid fields
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    And I follow "Next" within "div.customer div.location h2"
    And I follow "Edit" within "div.customer div.contacts ul.record:last-child li.actions"
    # Then I should be on the customer's location's contact's edit page
    And I fill in the contact form with valid values
    And I press "Save Contact"
    Then I should see "Contact was successfully updated."
    And I should see all the contacts from 2nd location and 2nd customer
  
  Scenario: Attempt to update a contact with invalid input from a location
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    And I follow "Next" within "div.customer div.location h2"
    And I follow "Edit" within "div.customer div.contacts ul.record:last-child li.actions"
    # Then I should be on the customer's location's contact's edit page
    And I fill in the contact form with invalid values
    And I press "Save Contact"
    Then I should see "errors prohibited this contact from being saved:"
    And I should see all the contacts from 2nd location and 2nd customer
    
    Scenario: Delete a contact
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 1st customer row
    And I follow "Delete" within "div.customer div.contacts ul.record:last-child li.actions"
    Then contact should not exist with id: 3
    And I should see all the contacts from 1st location and 1st customer