Feature: Manage contacts
  In order to manage contacts of a location
  As a user
  I want to perform serveral contacts operations
  
	@test
  Scenario: View all contacts of different locations within a customer
	  Given I sign up as user
		And 3 customers exist
	  When I go to the customers page
	  And I click "Container-open" in the 2nd customer row
		Then I should see the all contacts from 1st location and 2nd customer
		When I follow "Next" within "div.customer div.location h2"
		Then I should see the all contacts from 2nd location and 2nd customer
		When I follow "Next" within "div.customer div.location h2"
		Then I should see the all contacts from 3rd location and 2nd customer


    
  Scenario: Create a contact within a customers location
    Given I sign up as user
		And the following customer:
      | name | customer name |
      | shortname | shortname shortname |
      | website | www.example.org |
    And the following location:
      | name | location name |
      | street | location street |
      | zip | 12345 |
      | city | location city |
      | fon | 1234567890 |
      | fax | 1234567890 |
      | customer_id | 1 |
    When I go to the customers page
    And I click "Container-open" in the 1st customer row
    And I fill in the form with within "div.customer div.contacts":
      | Salutation | Mr. |
      | contact_title | Dr. |
      | Firstname | contact firstname |
      | Lastname | contact lastname |
      | Department | contact department |
      | Email | test@example.org |
      | Fon | 1234567890 |
      | Mobile |1234567890 |
      | Fax | 1234567890 |
    And I press "Save Contact"
    Then I should see the following customer contact:      
      | Mr. Dr. contact firstname contact lastname | |
      | contact department | |
      | Fon: 1234567890\nFax: 1234567890\nMobile: 1234567890 | |
      | | |
      
      
  Scenario: Edit a contact within a customers location
    Given I sign up as user
		And the following customer:
      | name | customer name |
      | shortname | shortname shortname |
      | website | www.example.org |
    And the following location:
      | name | location name |
      | street | location street |
      | zip | 12345 |
      | city | location city |
      | fon | 1234567890 |
      | fax | 1234567890 |
      | customer_id | 1 |
    And the following contact:
      | salutation | Mr. |
      | title | Dr. |
      | firstname | contact firstname |
      | lastname | contact lastname |
      | department | contact department |
      | email | test@example.org |
      | fon | 1234567890 |
      | mobile |1234567890 |
      | fax | 1234567890 |
      | location_id | 1 |
    When I go to the customers page
    And I click "Container-open" in the 1st customer row
    And I follow "Edit" within "div.customer div.contacts ul.record li.actions"
    
    
  Scenario: Delete a contact within a customers location
    Given I sign up as user
		And the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
      | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 1 |
    When I go to the customers page
    And I click "Container-open" in the 1st customer row
    And I follow "Delete" within "div.customer div.contacts ul.record:last-child li.actions"
    Then I should see the following customer contact:      
      | Mr. Dr. firstname 1 lastname 1 | |
      | department 1 | |
      | Fon: 12345667899\nFax: 12345667899\nMobile: 12345667899 | |
      | | |