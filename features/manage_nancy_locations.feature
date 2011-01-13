Feature: Manage customers
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: View a customers location
    Given the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11 | city 1 | 12345667899 | 12345667899 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | salutation 1 | title 1 | firstname 1 | lastname 1 | department 1 | email 1 | 12345667899 | mobile 1 | fax 1 | 1 | 
      | salutation 2 | title 2 | firstname 2 | lastname 2 | department 2 | email 2 | 12345667899 | mobile 2 | fax 2 | 1 |
    When I go to the customers page
    And I click "O" in the 1st customer row
    Then I should see "location 1" within "div.customer div.location ul.record li:first-child"
    And I should see "street 1" within "div.customer div.location ul.record li:nth-child(2)"
    And I should see "11 city 1" within "div.customer div.location ul.record li:nth-child(3)"
    And I should see "Fon: 12345667899" within "div.customer div.location ul.record li:nth-child(4)"
    And I should see "Fax: 12345667899" within "div.customer div.location ul.record li:nth-child(5)"
    
  Scenario: Skip locations
    Given the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11 | city 1 | fon 1 | fax 1 | 1 | 
      | location 2 | street 2 | 12 | city 2 | fon 2 | fax 2 | 1 |
      | location 3 | street 3 | 13 | city 3 | fon 3 | fax 3 | 1 | 
    And the following contacts:
      | salutation | title | firstname | lastname | department | email | fon | mobile | fax | location_id | 
      | salutation 1 | title 1 | firstname 1 | lastname 1 | department 1 | email 1 | fon 1 | mobile 1 | fax 1 | 1 | 
      | salutation 2 | title 2 | firstname 2 | lastname 2 | department 2 | email 2 | fon 2 | mobile 2 | fax 2 | 2 |
      | salutation 3 | title 3 | firstname 3 | lastname 3 | department 3 | email 3 | fon 3 | mobile 3 | fax 3 | 3 | 
    When I go to the customers page
    And I click "O" in the 1st customer row
    Then I should see "location 1" within "div.customer div.location ul.record li:first-child"
    And I should see "firstname 1 lastname 1" within "div.customer div.contacts ul.record li:first-child"
    When I follow "Next" within "div.customer div.location h2"
    Then I should see "location 2" within "div.customer div.location ul.record li:first-child"
    And I should see "firstname 2 lastname 2" within "div.customer div.contacts ul.record li:first-child"
    When I follow "Next" within "div.customer div.location h2"
    Then I should see "location 3" within "div.customer div.location ul.record li:first-child"
    And I should see "firstname 3 lastname 3" within "div.customer div.contacts ul.record li:first-child"
    When I follow "Previous" within "div.customer div.location h2"
    Then I should see "location 2" within "div.customer div.location ul.record li:first-child"
    And I should see "firstname 2 lastname 2" within "div.customer div.contacts ul.record li:first-child"
    When I follow "Previous" within "div.customer div.location h2"
    Then I should see "location 1" within "div.customer div.location ul.record li:first-child"
    And I should see "firstname 1 lastname 1" within "div.customer div.contacts ul.record li:first-child"
  
  Scenario: Create a Location within a customer
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
    And I fill in the form with within "div.customer div.location":
      | Name | location name 2 |
      | Street | location street 2 |
      | Zip | 12345 |
      | location_city | location city 2 |
      | Fon | 12345667890-2 |
      | Fax | 12345667899-2 |
    And I press "Save Location"
    Then I should see the following customer location:
      | location name 2 | |
      | location street 2 | |
      | 12345 location city 2 | |
      | Fon: 12345667890-2 | |
      | Fax: 12345667899-2 | |
      
  Scenario: Edit a Location within a customer
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
    And I follow "E" within "div.customer div.location span.actions"
    
    
    
  Scenario: Delete location within customer
    Given the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
    And the following locations:
      | name | street | zip | city | fon | fax | customer_id | 
      | location 1 | street 1 | 11 | city 1 | 12345667890 | 12345667890 | 1 | 
      | location 2 | street 2 | 12 | city 2 | 12345667890 | 12345667890 | 1 |
      | location 3 | street 3 | 13 | city 3 | 12345667890 | 12345667890 | 1 | 
    When I go to the customers page
    And I click "O" in the 1st customer row
    Then I should see "Location 1 of 3" within "div.customer div.location h2"
    When I follow "Next" within "div.customer div.location h2"
    And I follow "D" within "div.customer div.location span.actions"
    Then I should see "Location 1 of 2" within "div.customer div.location h2"
    And I should see the following customer location:
      | location 1 | |
      | street 1 | |
      | 11 city 1 | |
      | Fon: 12345667890 | |
      | Fax: 12345667890 | |