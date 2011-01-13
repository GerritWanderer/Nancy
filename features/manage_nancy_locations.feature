Feature: Manage customers
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
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