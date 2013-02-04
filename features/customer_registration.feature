Feature: Customer needs to register
  In order to customer track his service requests
  Customer can manage by himself his service orders


Scenario: Sign up new customer
  Given I am on the home page
  And I follow "Sign up"
  Then within form user
  Then I fill in "email" with "customer@easyservice.cz"
  And I fill in "password" with "password"
  And I fill in "password_confirmation" with "password"
  And I click on button "Sign up"
  Then I should be at the customer dashboard show page
  And I should see within "h2" message "customer@easyservice.cz"
  #And save and open page