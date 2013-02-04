Feature: Login to account
  In order to be able to manege customer account

  @no-txn
  Scenario: Login as customer
    Given a valid user exists
    And I am on the home page
    And I follow "Sign in"
    And I am on the users sign in page
    And within form user
    When I fill in "email" with "customer@easyservice.cz"
    And I fill in "password" with "password"
    And I click on button "Sign in"
    Then I should be at the customer dashboard show page

