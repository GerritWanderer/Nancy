Feature: Manage contacts
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: View contacts within a customers location
    Given the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11111 | city 1 | 12345667899-1 | 12345667899-1 | 1 | 
      | location 2 | street 2 | 22222 | city 2 | 12345667899-2 | 12345667899-2 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | Mr. | Dr. | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | 12345667899 | 12345667899 | 1 | 
      | Mr. | Dr. Dr. | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | 12345667899 | 12345667899| 2 |
      | Mr. | Dr. | firstname 3 | lastname 3 | department 3 | email 3 | 12345667899 | 12345667899 | 12345667899 | 2 |
    When I go to the customers page
    And I click "O" in the 1st customer row
    And I follow "Next" within "div.customer div.location h2"
    Then I should see "location 2" within "div.customer div.location ul.record li:first-child"
    And I should see "Mr. Dr. firstname 3 lastname 3" within "div.customer div.contacts ul.record:last-child li:nth-child(1)"
    And I should see "department 3" within "div.customer div.contacts ul.record:last-child li:nth-child(2)"
    And I should see "Fon: 12345667899" within "div.customer div.contacts ul.record:last-child li span:nth-child(1)"
    And I should see "Fax: 12345667899" within "div.customer div.contacts ul.record:last-child li span:nth-child(2)"
    And I should see "Mobile: 12345667899" within "div.customer div.contacts ul.record:last-child li span:nth-child(3)"
    
  Scenario: Create a contact within a customers location
    Given the following customer:
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
    And I click "O" in the 1st customer row
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
      | M\nE\nD | |
      
      
  Scenario: Edit a contact within a customers location
    Given the following customer:
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
    And I click "O" in the 1st customer row
    And I follow "E" within "div.customer div.contacts ul.record li.actions"
    
    
  Scenario: Delete a contact within a customers location
    Given the following customers:
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
    And I click "O" in the 1st customer row
    And I follow "D" within "div.customer div.contacts ul.record:last-child li.actions"
    Then I should see the following customer contact:      
      | Mr. Dr. firstname 1 lastname 1 | |
      | department 1 | |
      | Fon: 12345667899\nFax: 12345667899\nMobile: 12345667899 | |
      | M\nE\nD | |