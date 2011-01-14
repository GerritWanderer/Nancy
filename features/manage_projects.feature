# Generated by cucumber_scaffold - http://github.com/andyw8/cucumber_scaffold

Feature: Manage projects
  In order to [goal]
  [stakeholder]
  wants [behaviour]

    Scenario: List all projects
      Given the following projects:
        | title | description | discount | budget | type | closed | customer | contact | 
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x00000106087850> | #<Contact:0x00000105499bb0> | 
        | title 2 | description 2 | 12 | 12 | 12 | true | #<Customer:0x0000010534b100> | #<Contact:0x00000105345200> | 
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x0000010532bb20> | #<Contact:0x00000105323c18> | 
      When I go to the projects page
      Then I should see the following projects:
        | Title | Description | Discount | Budget | Type | Closed | Customer | Contact | 
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x00000105306988> | #<Contact:0x000001052fdba8> | 
        | title 2 | description 2 | 12 | 12 | 12 | true | #<Customer:0x000001052e43d8> | #<Contact:0x000001052dc2f0> | 
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x000001052c9268> | #<Contact:0x000001052c37a0> |
      And the heading should be "Listing projects"
      

    Scenario: View a project
      Given the following projects:
        | title | description | discount | budget | type | closed | customer | contact |
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x000001052ab448> | #<Contact:0x000001052a4198> | 
        | title 2 | description 2 | 12 | 12 | 12 | true | #<Customer:0x000001052875c0> | #<Contact:0x000001052804f0> |
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x0000010526b820> | #<Contact:0x00000105262040> |
      When I go to the projects page
      And I click "Show" in the 2nd row
      Then I should see the following project:
        | Title: | title 2 |
        | Description: | description 2 |
        | Discount: | 12 |
        | Budget: | 12 |
        | Type: | 12 |
        | Closed: | true |
        | Customer: | #<Customer:0x00000105246ef8> |
        | Contact: | #<Contact:0x000001052411b0> |
                  
      When I follow "Back"
      
      Then I should be on the projects page

    Scenario: Edit a project
      Given the following project:
        | title | title 10 |
        | description | description 10 |
        | discount | 20 |
        | budget | 20 |
        | type | 20 |
        | closed | true |
        | customer | #<Customer:0x00000105238100> |
        | contact | #<Contact:0x0000010522fa50> |
      When I go to the page for that project
      And I follow "Edit"
      Then I should see the following form field values:
        | Title | title 10 |
        | Description | description 10 |
        | Discount | 20 |
        | Budget | 20 |
        | Type | 20 |
        | Closed | [x] |
        | Customer | #<Customer:0x00000105223ef8> |
        | Contact | #<Contact:0x000001051fe810> |
      Then the heading should be "Editing project"
      
      When I follow "Show"
      Then I should be on the page for that project

    Scenario: Delete a project via the index page
      Given the following projects:
        | title | description | discount | budget | type | closed | customer | contact | 
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x000001051da870> | #<Contact:0x000001051cfe70> | 
        | title 2 | description 2 | 12 | 12 | 12 | true | #<Customer:0x0000010515c650> | #<Contact:0x00000105151d40> | 
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x000001050ca340> | #<Contact:0x000001050c3ae0> |
      When I go to the projects page
      And I click "Destroy" in the 2nd row
      Then I should see the following projects:
        | Title | Description | Discount | Budget | Type | Closed | Customer | Contact | 
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x000001050a35d8> | #<Contact:0x0000010509bbd0> | 
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x0000010507c028> | #<Contact:0x00000105071308> |
      And I should be on the projects page
      
    
    Scenario: New project page  
      Given I am on the projects page
      When I follow "New Project"
      Then I should be on the new project page
      
      When I follow "Back"
      Then I should be on the projects page

    Scenario: Create a new project
      Pending
      # Given I am on the new project page
      # When I fill in the form with:
      #   | Title | title 10 |
        # | Description | description 10 |
        # | Discount | 20 |
        # | Budget | 20 |
        # | Type | 20 |
        # | Closed | [x] |
        # | Customer | #<Customer:0x00000105043d68> |
        # | Contact | #<Contact:0x0000010503b7d0> |
      # And I press "Create"
      # Then I should see "Project was successfully created."
      # And I should see the following project:
      #   | Title: | title 10 |
        # | Description: | description 10 |
        # | Discount: | 20 |
        # | Budget: | 20 |
        # | Type: | 20 |
        # | Closed: | true |
        # | Customer: | #<Customer:0x00000105031938> |
        # | Contact: | #<Contact:0x0000010502de00> |

    Scenario: Attempt to create a new project with invalid input
      Pending
      # You should use this scenario as the basis for scenarios involving ActiveRecord validations, or delete it if it's not required
      # Given I am on the new project page
      # When I fill in the form with:
      #   | Title | title 10 |
        # | Description | description 10 |
        # | Discount | 20 |
        # | Budget | 20 |
        # | Type | 20 |
        # | Closed | [x] |
        # | Customer | #<Customer:0x00000105024b48> |
        # | Contact | #<Contact:0x0000010501bc28> |
      # And I press "Create"
      # Then I should see "1 error prohibited this project from being saved:"
      #
      # [You should add checks for specific errors here. It may be appropriate to add extra scenarios.]
      #
      # And I should see the following form field values:
      #   | Title | title 10 |
        # | Description | description 10 |
        # | Discount | 20 |
        # | Budget | 20 |
        # | Type | 20 |
        # | Closed | [x] |
        # | Customer | #<Customer:0x0000010500ba80> |
        # | Contact | #<Contact:0x0000010387a448> |

    Scenario: Attempt to update a project with invalid input
      Pending
      # You should use this scenario as the basis for scenarios involving ActiveRecord validations, or delete it if it's not required
      # Given a project exists
      # When I go to the edit page for that project
      # And I fill in the form with:
      #   | Title | title 10 |
        # | Description | description 10 |
        # | Discount | 20 |
        # | Budget | 20 |
        # | Type | 20 |
        # | Closed | [x] |
        # | Customer | #<Customer:0x0000010385de60> |
        # | Contact | #<Contact:0x000001038467d8> |
      # And I press "Update"
      # Then I should see "1 error prohibited this project from being saved:"
      #
      # [You should add checks for specific errors here. It may be appropriate to add extra scenarios.]
      #
      # And I should see the following form field values:
      #   | Title | title 10 |
        # | Description | description 10 |
        # | Discount | 20 |
        # | Budget | 20 |
        # | Type | 20 |
        # | Closed | [x] |
        # | Customer | #<Customer:0x00000103829f98> |
        # | Contact | #<Contact:0x00000103820790> |

    Scenario: Update a project
      Given the following project:
        | title | title 10 |
        | description | description 10 |
        | discount | 20 |
        | budget | 20 |
        | type | 20 |
        | closed | true |
        | customer | #<Customer:0x0000010380afd0> |
        | contact | #<Contact:0x00000101ff1a20> |
      When I go to the edit page for that project
      And I fill in the form with:
        | Title | title 10 updated |
        | Description | description 10 updated |
        | Discount | -20 |
        | Budget | -20 |
        | Type | -20 |
        | Closed | [ ] |
        | Customer | #<Customer:0x00000101fd9538> |
        | Contact | #<Contact:0x00000101fbe800> | 
      And I press "Update"
      Then I should be on the page for that project
      And I should see "Project was successfully updated."
      And I should see the following project:
        | Title: | title 10 updated |
        | Description: | description 10 updated |
        | Discount: | -20 |
        | Budget: | -20 |
        | Type: | -20 |
        | Closed: | false |
        | Customer: | #<Customer:0x00000101fa0698> |
        | Contact: | #<Contact:0x00000101f5d050> |

    Scenario: Navigate from projects page to the edit project page
      Given the following projects:
        | title | description | discount | budget | type | closed | customer | contact | 
        | title 1 | description 1 | 11 | 11 | 11 | true | #<Customer:0x00000101f53190> | #<Contact:0x00000101f49820> | 
        | title 2 | description 2 | 12 | 12 | 12 | true | #<Customer:0x00000101f33818> | #<Contact:0x00000101f30078> | 
        | title 3 | description 3 | 13 | 13 | 13 | true | #<Customer:0x00000101f205d8> | #<Contact:0x00000101f19dc8> |
      When I go to the projects page
      And I click "Edit" in the 2nd row
      Then I should be on the edit page for the 2nd project

    Scenario: Navigate from edit project page to the projects page
      Given a project exists
      When I go to the edit page for that project
      And I follow "Back"
      Then I should be on the projects page