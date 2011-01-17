Feature: Manage projects
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: List all projects
		Given the following customers:
	    | name | shortname | website |
	    | Customer 1 | shortname 1 | website 1 |
	    | Customer 2 | shortname 2 | website 2 |
	  And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 |
	  And the following projects:
	    | title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
	    | title 1 | description 1 | 11 | 11 | 11 | 0 | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 2 | description 2 | 12 | 12 | 12 | 0 | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 3 | description 3 | 13 | 13 | 13 | 0 | 2 | 3 | 1970-01-03 20:00:00 |
	  When I go to the projects page
	  Then I should see the following projects:
	    | 1 | title 1 | Customer 1 | 1970-01-01 | |
	    | 2 | title 2 | Customer 1 | 1970-01-02 | |
	    | 3 | title 3 | Customer 2 | 1970-01-03 | |
	
  Scenario: Filter projects by closed status
		Given the following customers:
	    | name | shortname | website |
	    | Customer 1 | shortname 1 | website 1 |
	    | Customer 2 | shortname 2 | website 2 |
	  And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 |
	  And the following projects:
	    | title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
	    | title 1 | description 1 | 11 | 11 | 11 | 0 | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 2 | description 2 | 12 | 12 | 12 | 0 | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 3 | description 3 | 13 | 13 | 13 | 0 | 2 | 3 | 1970-01-03 20:00:00 |
	    | title 4 | description 1 | 11 | 11 | 11 | 1 | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 5 | description 2 | 12 | 12 | 12 | 1 | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 6 | description 3 | 13 | 13 | 13 | 1 | 2 | 3 | 1970-01-03 20:00:00 |
	  When I go to the projects page
		# And I follow "Active Projects" within "div.filter ul li:nth-child(2)"
		# 	  And I should see the following projects:
		# 	    | 1 | title 1 | Customer 1 | 1970-01-01 | |
		# 	    | 2 | title 2 | Customer 1 | 1970-01-02 | |
		# 	    | 3 | title 3 | Customer 2 | 1970-01-03 | |
		# When I follow "Closed Projects" within "div.filter ul li:nth-child(3)"
		# 	  Then I should see the following projects:
		# 	    | 4 | title 4 | Customer 1 | 1970-01-01 | |
		# 	    | 5 | title 5 | Customer 1 | 1970-01-02 | |
		# 	    | 6 | title 6 | Customer 2 | 1970-01-03 | |
		When I follow "All Projects" within "div.filter ul li"
	  Then I should see the following projects:
	    | 1 | title 1 | Customer 1 | 1970-01-01 | |
	    | 2 | title 2 | Customer 1 | 1970-01-02 | |
	    | 3 | title 3 | Customer 2 | 1970-01-03 | |
	    | 4 | title 4 | Customer 1 | 1970-01-01 | |
	    | 5 | title 5 | Customer 1 | 1970-01-02 | |
	    | 6 | title 6 | Customer 2 | 1970-01-03 | |
      
  Scenario: View a projects
    Given the following customers:
      | name | shortname | website |
      | Customer 1 | shortname 1 | website 1 |
      | Customer 2 | shortname 2 | website 2 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
      | location 2 | street 2 | 22222 | city 2 | 12345667899-2 | 12345667899-2 | 2 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
      | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 1 |
      | Mr. | Dr. | firstname 3 | lastname 3 | department 3 | email 3 | 12345667899 | 12345667899 | 12345667899 | 2 |
    And the following projects:
      | title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
      | title 1 | description 1 | 11 | 111 | 1 | 0 | 1 | 1 | 1970-01-01 20:00:00 |
      | title 2 | description 2 | 12 | 121 | 1 | 0 | 1 | 2 | 1970-01-02 20:00:00 |
      | title 3 | description 3 | 13 | 131 | 1 | 0 | 2 | 3 | 1970-01-03 20:00:00 |
    When I go to the projects page
    And I click "Container-open" in the 2nd project row
    And I should see "2" within "div.project ul.title#active li:first-child"
    And I should see "title 2" within "div.project ul.title#active li:nth-child(2)"
    And I should see "Customer 1" within "div.project ul.title#active li:nth-child(3)"
		And I should see "1970-01-02" within "div.project ul.title#active li:nth-child(4)"
		And I should see "description 2" within "div.project div.main dl dd.description"
		And I should see "12" within "div.project div.main dl dd:nth-child(6)"
		And I should see "121" within "div.project div.main dl dd:nth-child(4)"
		And I should see "Mr. Dr. Dr. firstname 2 lastname 2" within "div.project div.contacts ul.record li.name"
		And I should see "Fon: 12345667899 Fax: 12345667899 Mobile: 12345667899" within "div.project div.contacts ul.record li.fon"
		And I should see "location 1 street 1 11111 city 1" within "div.project div.contacts ul.record li.location"
    When I follow "Container-close" within "div.project ul.title#active li.actions"
    Then I should be on the projects page
    
  Scenario: Switch closed status of a project
    Given the following customers:
	    | name | shortname | website |
	    | Customer 1 | shortname 1 | website 1 |
	    | Customer 2 | shortname 2 | website 2 |
	  And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
      | location 2 | street 2 | 22222 | city 2 | 12345667899-2 | 12345667899-2 | 2 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
      | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 1 |
      | Mr. | Dr. | firstname 3 | lastname 3 | department 3 | email 3 | 12345667899 | 12345667899 | 12345667899 | 2 |
	  And the following projects:
	    | title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
	    | title 1 | description 1 | 11 | 111 | 1 | 0 | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 2 | description 2 | 12 | 121 | 1 | 0 | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 3 | description 3 | 13 | 131 | 1 | 0 | 2 | 3 | 1970-01-03 20:00:00 |
    When I go to the projects page
    And I click "Container-open" in the 2nd project row
    When I follow "Project-close" within "div.project div.main span.actions"
    Then I should see "Project status was successfully switched."

  Scenario: Create a new project
		Given the following customers:
	    | name | shortname | website |
	    | Customer 1 | shortname 1 | website 1 |
	    | Customer 2 | shortname 2 | website 2 |
	  And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
      | location 2 | street 2 | 22222 | city 2 | 12345667899-2 | 12345667899-2 | 2 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
      | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 1 |
      | Mr. | Dr. | firstname 3 | lastname 3 | department 3 | email 3 | 12345667899 | 12345667899 | 12345667899 | 2 |
    And I am on the projects page
    When I fill in the form with:
      | Title | Project name |
      | Description | Lorem Ipsum |
      | Discount | 5 |
      | Budget | 100 |
    And I press "Save"
    Then I should see "Project was successfully created."
    And I should see the following project:
      |1||
			| Project name | |
      | Customer 1 | |
      | 2011-01-17 | |
			|||
		
  Scenario: Edit a project
		Given the following customers:
	    | name | shortname | website |
	    | Customer 1 | shortname 1 | website 1 |
	    | Customer 2 | shortname 2 | website 2 |
	  And the following locations:
	    | name | street | zip | city | fon | fax | customer_id | 
	    | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
	    | location 2 | street 2 | 22222 | city 2 | 12345667899-2 | 12345667899-2 | 2 | 
	  And the following contacts:
	    | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
	    | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
	    | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 1 |
	    | Mr. | Dr. | firstname 3 | lastname 3 | department 3 | email 3 | 12345667899 | 12345667899 | 12345667899 | 2 |
		And the following projects:
			| title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
	    | title 1 | description 1 | 11 | 11 | 11 | true | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 2 | description 2 | 12 | 12 | 12 | true | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 3 | description 3 | 13 | 13 | 13 | true | 2 | 3 | 1970-01-03 20:00:00 |
    When I go to the projects page
    And I click "Edit" in the 1st project row
    #Then I should be on the edit page for that project
    #check field values
		
    # Scenario: Update a project
    #   Given the following project:
    #     | title | title 10 |
    #     | description | description 10 |
    #     | discount | 20 |
    #     | budget | 20 |
    #     | type | 20 |
    #     | closed | true |
    #     | customer | #<Customer:0x0000010380afd0> |
    #     | contact | #<Contact:0x00000101ff1a20> |
    #   When I go to the edit page for that project
    #   And I fill in the form with:
    #     | Title | title 10 updated |
    #     | Description | description 10 updated |
    #     | Discount | -20 |
    #     | Budget | -20 |
    #     | Type | -20 |
    #     | Closed | [ ] |
    #     | Customer | #<Customer:0x00000101fd9538> |
    #     | Contact | #<Contact:0x00000101fbe800> | 
    #   And I press "Update"
    #   Then I should be on the page for that project
    #   And I should see "Project was successfully updated."
    #   And I should see the following project:
    #     | Title: | title 10 updated |
    #     | Description: | description 10 updated |
    #     | Discount: | -20 |
    #     | Budget: | -20 |
    #     | Type: | -20 |
    #     | Closed: | false |
    #     | Customer: | #<Customer:0x00000101fa0698> |
    #     | Contact: | #<Contact:0x00000101f5d050> |


  Scenario: Delete a project via the index page
    Given the following customers:
      | name | shortname | website |
      | Customer 1 | shortname 1 | website 1 |
      | Customer 2 | shortname 2 | website 2 |
      | Customer 3 | shortname 3 | website 3 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11 | city 1 | fon 1 | fax 1 | 1 | 
      | location 2 | street 2 | 12 | city 2 | fon 2 | fax 2 | 2 | 
      | location 3 | street 3 | 13 | city 3 | fon 3 | fax 3 | 3 |
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | salutation 1 | title 1 | firstname 1 | lastname 1 | department 1 | email 1 | fon 1 | mobile 1 | fax 1 | 1 | 
      | salutation 2 | title 2 | firstname 2 | lastname 2 | department 2 | email 2 | fon 2 | mobile 2 | fax 2 | 2 | 
      | salutation 3 | title 3 | firstname 3 | lastname 3 | department 3 | email 3 | fon 3 | mobile 3 | fax 3 | 3 |
		And the following projects:
			| title | description | discount | budget | type | closed | customer_id | contact_id | created_at |
	    | title 1 | description 1 | 11 | 11 | 11 | true | 1 | 1 | 1970-01-01 20:00:00 |
	    | title 2 | description 2 | 12 | 12 | 12 | true | 1 | 2 | 1970-01-02 20:00:00 |
	    | title 3 | description 3 | 13 | 13 | 13 | true | 2 | 3 | 1970-01-03 20:00:00 |
    When I go to the projects page
    And I click "Delete" in the 2nd project row
    And I should see the following projects:
	    | 1 | title 1 | Customer 1 | 1970-01-01 | |
	    | 3 | title 3 | Customer 2 | 1970-01-03 | |
    And I should be on the projects page