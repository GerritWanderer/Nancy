Feature: Manage customers
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: List all customers
    Given the following customers:
      | name | shortname | website | 
      | name 1 | shortname 1 | website 1 | 
      | name 2 | shortname 2 | website 2 | 
      | name 3 | shortname 3 | website 3 | 
    When I go to the customers page
    Then I should see the following customers:
      | name 1 | shortname 1 | 0 | O\nE\nD |
      | name 2 | shortname 2 | 0 | O\nE\nD |
      | name 3 | shortname 3 | 0 | O\nE\nD |
    
    
  Scenario: View a customer
    Given the following customers:
      | name | shortname | website |
      | name 1 | shortname 1 | website 1 |
      | name 2 | shortname 2 | website 2 |
      | name 3 | shortname 3 | website 3 |
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
    When I go to the customers page
    And I click "O" in the 2nd customer row
    Then I should see "name 2" within "div.customer ul.titleActive li:first-child"
    And I should see "shortname 2" within "div.customer ul.titleActive li:nth-child(2)"
    And I should see "1" within "div.customer ul.titleActive li:nth-child(3)"
    
    
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
    
    
  Scenario: Create a new customer with Main Location/Contact
    Given I am on the customers page
    When I fill in the form with:
      | Name | customer name |
      | Shortname | customer shortname |
      | Website | www.example.org |
      | customer_locations_attributes_0_name | location name |
      | Street | location street |
      | Zip | 12345 |
      | customer_locations_attributes_0_city | location city |
      | customer_locations_attributes_0_fon | 12345667890 |
      | customer_locations_attributes_0_fax | 12345667899 |
      | Salutation | Herr |
      | customer_locations_attributes_0_contacts_attributes_0_title | Dr. |
      | Firstname | Max |
      | Lastname | Mustermann|
      | Department | Web |
      | Email | test@example.org |
      | customer_locations_attributes_0_contacts_attributes_0_fon | 12345667890 |
      | customer_locations_attributes_0_contacts_attributes_0_fax | 12345667899 |
      | Mobile | 12345667899 |
    And I press "Save"
    Then I should see "Customer was successfully created."
    And I should see the following customer:
      | customer name | |
      | customer shortname | |
      | 1 | |
      | C\nE\nD | |
    And I should see the following customer location:
      | location name | |
      | location street | |
      | 12345 location city | |
      | Fon: 12345667890 | |
      | Fax: 12345667899 | |
    And I should see the following customer contact:
      | Herr Dr. Max Mustermann | |
      | Web | |
      | Fon 12345667890\nFax 12345667899\nMobile 12345667899 | |
      | M\nE\nD | |
      
      
  Scenario: Edit a customer
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
    And I click "E" in the 1st customer row
    Then I should be on the edit page for that customer
    #check field values
    
    
    Scenario: Delete a customer via the index page
      Given the following customers:
        | name | shortname | website |
        | name 1 | shortname 1 | website 1 |
        | name 2 | shortname 2 | website 2 |
        | name 3 | shortname 3 | website 3 |
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
      When I go to the customers page
      And I click "D" in the 2nd customer row
      Then I should see the following customers:
        | name 1 | shortname 1 | 1 | O\nE\nD |
        | name 3 | shortname 3 | 1 | O\nE\nD |
      And I should be on the customers page