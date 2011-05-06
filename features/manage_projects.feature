Feature: Manage projects
  In order to manage projects
  As a user
  I want to perform serveral project operations

  Scenario: List all projects
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    Then I should see all projects with closed status "false"
  
  Scenario: Change order of active projects
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I follow "Active Projects"
    And I follow "Order-down" within "div.toolbar li:first-child"
    Then I should see all projects ordered "id" "desc" with closed status "false"
    When I follow "Order-up" within "div.toolbar li:first-child"
    Then I should see all projects ordered "id" "asc" with closed status "false"
    When I follow "Order-down" within "div.toolbar li:nth-child(2)"
    Then I should see all projects ordered "title" "desc" with closed status "false"
    When I follow "Order-up" within "div.toolbar li:nth-child(2)"
    Then I should see all projects ordered "title" "asc" with closed status "false"
    When I follow "Order-down" within "div.toolbar li:nth-child(4)"
    Then I should see all projects ordered "created_at" "desc" with closed status "false"
    When I follow "Order-up" within "div.toolbar li:nth-child(4)"
    Then I should see all projects ordered "created_at" "asc" with closed status "false"
    
  Scenario: Filter projects by closed status
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    When I follow "Active Projects" within "div.filter li:nth-child(2)"
    Then I should see all projects with closed status "false"
    When I follow "Closed Projects" within "div.filter li:nth-child(3)"
    Then I should see all projects with closed status "true"
    # And I follow "All Projects" within "div.filter li:first-child"
    # Then I should see all projects

  Scenario: View a project
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Container-open" in the 2nd project row
    Then I should see the 2nd project active
  
  Scenario: Jump from a projects view to index
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Container-open" in the 2nd project row
    Then I should see the 2nd project active
    When I click "Container-close" in the 2nd project row
    Then I should be on the projects page

  Scenario: Create a valid project
    Given I sign up as user
    And 3 customers exist
    And I am on the projects page
    When I fill in the project form with valid values
    And I press "Save"
    Then I should see "Project was successfully created."
    And I should see the 1st project active

  Scenario: Attempt to create a new project with invalid input
    Given I sign up as user
    And 3 customers exist
    And I am on the projects page
    When I fill in the project form with invalid values
    And I press "Save"
    Then I should see "errors prohibited this project from being saved:"

  @wip
  Scenario: Navigate from projects page to the edit project page
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Edit" in the 2nd project row
    Then I should be on the edit page for the 2nd customer

  @wip
  Scenario: Navigate from projects view page to the edit project page
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Container-open" in the 2nd project row
    And I click "Edit" in the 2nd project row
    Then I should be on the edit page for that project

  Scenario: Update a project with valid fields
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Edit" in the 2nd project row
    And I fill in the project form with valid values
    And I press "Save"
    Then I should see "Project was successfully updated."
    And I should see the 2nd project active

  Scenario: Attemp to update a project with invalid fields
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Edit" in the 2nd project row
    And I fill in the project form with invalid values
    And I press "Save"
    Then I should see "errors prohibited this project from being saved:"

  Scenario: Delete a project
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Delete" in the 2nd project row
    Then project should not exist with id: 2
    And I should see all projects with closed status "false"
 
  Scenario: Switch closed status of a project
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the active projects page
    And I click "Container-open" in the 2nd project row
    When I follow "Project-close" within "div.project span.actions"
    Then I should see "Project was successfully changed."

  Scenario: Open Work-Report of a project
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    And 3 works exist
    When I go to the active projects page
    And I click "Container-open" in the 2nd project row
    When I follow "Project-report" within "div.project span.actions"
    Then I should see all works for the 2nd project