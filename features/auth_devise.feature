Feature: Use auth. from devise
  In order to use the auth. functionality
  As a guest
  I want to use all features for signup/signin

  Scenario: Sign up successfully with confirmation and 1st customer wizard
    Given I sign up as user with customer wizard
    Then I should be on the works page
    And I should see "Nancy is now ready for use"

  Scenario: Sign in successfully
    Given I sign up as user with customer wizard
    And I am not authenticated
    When I go to the login page
    And I fill in "user_email" with "admin@wildner-designer.de"
    And I fill in "user_password" with "test123"
    And I press "Sign in"
    Then I should be on the works page

  Scenario: Visit protected Pages unsuccessfully as guest
    Given I am not authenticated
    When I go to the works page
    Then I should see "You need to sign in or sign up before continuing."
    And I am on the login page
    When I go to the customers page
    Then I should see "You need to sign in or sign up before continuing."
    And I am on the login page
    When I go to the projects page
    Then I should see "You need to sign in or sign up before continuing."
    And I am on the login page

  Scenario: Update Profile as authenticated User successfully
    Given I sign up as user
    And 3 customers exist
    And 10 projects exist
    When I go to the works page
    And I follow "profile" within "div#navigation ul li.small"
    And I fill in "user_firstname" with "Lucky"
    And I fill in "user_lastname" with "Luke"
    And I fill in "user_current_password" with "test123"
    And I press "Update"
    Then I should be on the works page
    And I should see "You updated your account successfully."