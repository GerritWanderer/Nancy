Feature: Manage customers
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Create a new customer with Main Location/Contact
    Given I am on the customers page
    When I fill in the form with:
      | Name | customer name |
      | Shortname | customer shortname |
      | Website | www.example.org |
      | customer_locations_attributes_0_name | location name |
      | Street | street 10 |
      | Zip | 20 |
      | customer_locations_attributes_0_city | city 10 |
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
      | Name: | customer name |
      | Shortname: | customer shortname |
      | Website: | www.example.org |