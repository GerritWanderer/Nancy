Feature: Use auth. from devise
  In order to use the auth. functionality
  As a guest
  I want to use all features for signup/signin
  
  Scenario: Sign up successfully with confirmation
    Given I am on the registration page
    When I fill in "user_firstname" with "Max"
    And I fill in "user_lastname" with "Mustermann"
    And I fill in "user_email" with "admin@wildner-designer.de"
		And I fill in "user_password" with "test123"
		And I fill in "user_password_confirmation" with "test123"
    When I press "Sign up"
    #Then show me the page
    #Then I should see "You have signed up successfully"
    And I should be on the login page
    And I should receive an email
    When I open the email
    Then I should see "Welcome admin@wildner-designer.de!" in the email body
    When they click the first link in the email
    #Then I should see "Your account was successfully confirmed"
		Then I should be on the root page
		
  Scenario: Sign in successfully
    Given I sign up as user
    And I am not authenticated
    When I go to the login page
    And I fill in "user_email" with "admin@wildner-designer.de"
    And I fill in "user_password" with "secretpass"
    And I press "Sign in"
    #And I should see "Signed in successfully."
		And I should be on the login page
		
  Scenario: Visit proztected Pages unsuccessfully as guest
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
    
  Scenario: Visit proztected Pages unsuccessfully as guest
    Given I sign up as user
    When I go to the works page
    Then I should not see "You need to sign in or sign up before continuing."
    And I am on the works page
    When I go to the customers page
    Then I should not see "You need to sign in or sign up before continuing."
    And I am on the customers page
    When I go to the projects page
    Then I should not see "You need to sign in or sign up before continuing."
    And I am on the projects page

  Scenario: Update Profile as authenticated User successfully
		Given I sign up as user
		And 3 customers exist
		And 10 projects exist
		And 6 works exist
		When I go to the works page
		And I follow "profile" within "div#navigation ul li.small"
    And I fill in "user_firstname" with "Lucky"
    And I fill in "user_lastname" with "Luke"
		And I fill in "user_current_password" with "test123"
    And I press "Update"
    Then I should see "You updated your account successfully."
		And I should see "Lucky Luke" within "div#navigation ul li.user"
		And I should be on the root page