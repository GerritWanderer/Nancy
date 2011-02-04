Feature: Manage customers
  In order to manage customers
  As a user
  I want to perform serveral customer operations
  
  Scenario: List all customers
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    Then I should see all customers

  Scenario: Change order of all customers
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I follow "Order-down" within "div.toolbar li:first-child"
    Then I should see all customers ordered "name" "desc"
    When I follow "Order-up" within "div.toolbar li:first-child"
    Then I should see all customers ordered "name" "asc"
    When I follow "Order-down" within "div.toolbar li:nth-child(2)"
    Then I should see all customers ordered "shortname" "desc"
    When I follow "Order-up" within "div.toolbar li:nth-child(2)"
    Then I should see all customers ordered "shortname" "asc"
  
  Scenario: View a customer
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    Then I should see the 2nd customer active
  
  Scenario: Jump from a customers view to index
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    Then I should see the 2nd customer active
    When I click "Container-close" in the 2nd customer row
    Then I should be on the customers page
  
  Scenario: Create a valid customer with Main Location/Contact
    Given I sign up as user
    And a customer exist
    And I am on the customers page
    When I fill in the customer form with valid values
    And I press "Save"
    Then I should see "Customer was successfully created."
    And I should see the 2nd customer active
  
  Scenario: Attempt to create a new customer with invalid input
    Given I sign up as user
    And a customer exist
    And I am on the customers page
    When I fill in the customer form with invalid values
    And I press "Save"
    Then I should see "errors prohibited this customer from being saved:"
    And I should be on the customers page
    
  @wip
  Scenario: Navigate from customers page to the edit customer page
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Edit" in the 2nd customer row
    Then I should be on the edit page for the 2nd customer
    
  @wip
  Scenario: Navigate from customer view page to the edit customer page
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Container-open" in the 2nd customer row
    And I click "Edit" in the 2nd customer row
    Then I should be on the edit page for that customer
    
  Scenario: Update a customer with valid fields
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Edit" in the 2nd customer row
    And I fill in the customer form with valid values
    And I press "Save"
    Then I should see "Customer was successfully updated."
    And I should see the 2nd customer active
  
  Scenario: Update a customer with invalid fields
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Edit" in the 2nd customer row
    And I fill in the customer form with invalid values
    And I press "Save"
    Then I should see "errors prohibited this customer from being saved:"

  Scenario: Delete a customer
    Given I sign up as user
    And 3 customers exist
    When I go to the customers page
    And I click "Delete" in the 2nd customer row
    Then customer should not exist with id: 2
    And I should be on the customers page