Given /^I am not authenticated$/ do
  visit('/logout')
end

Given /^I am authenticated$/ do
  When %{I go to the login page}
  And %{I fill in "user_email" with "admin@wildner-designer.de"}
  And %{I fill in "user_password" with "test123"}
  And %{I press "Sign in"}
end

Given /^I sign up as user$/ do
  firstname = 'Max'
  lastname = 'Mustermann'
  email = 'admin@wildner-designer.de'
  password = 'test123'
  
  When %{I go to the the registration page}
  And %{I fill in "user_firstname" with "#{firstname}"}
  And %{I fill in "user_lastname" with "#{lastname}"}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should receive an email}
  When %{I open the email}
  And %{they click the first link in the email}
end

Given /^I sign up as user with customer wizard$/ do
  firstname = 'Max'
  lastname = 'Mustermann'
  email = 'admin@wildner-designer.de'
  password = 'test123'
  customer = 'Company'
  location = 'location'
  street = 'Musterstr. 11'
  zip = '12345'
  city = 'Musterstadt'

  When %{I go to the the registration page}
  And %{I fill in "user_firstname" with "#{firstname}"}
  And %{I fill in "user_lastname" with "#{lastname}"}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should receive an email}
  When %{I open the email}
  And %{they click the first link in the email}
  And %{I should be on the customer wizard page}
  When %{I fill in "customer_name" with "#{customer}"}
  And %{I fill in "customer_locations_attributes_0_street" with "#{street}"}
  And %{I fill in "customer_locations_attributes_0_zip" with "#{zip}"}
  And %{I fill in "customer_locations_attributes_0_city" with "#{city}"}
  And %{I press "Save"}
end