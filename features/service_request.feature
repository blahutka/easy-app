Feature: Send request for PC service
  To get good price

#  Scenario: Create Service request
#    Given I submit service request in "serial_num" with "233"
#    And I submit service request in "serial_num" with "122"
#    Then I am on the home page
#    And I should see within "div.history" message "233"
#    And I should see within "div.history" message "122"
#    And save and open page

  @logout_customer
  Scenario: Not logged in customer submit new service request
    Given I am on home page
    And a valid user exists
    And I submit valid service request
    And a valid service request exists
    And I should be at the valid service request's page
    And I click on link "submit_service_request"
    Then I should be at the users sign in page
  #  # TODO fill password and email now default from form
    And I click on button "Sign in"
    And I should be at the service request's customer page

#And save and open page

  Scenario: User sign in and create invalid service request
    Given customer user is logged in
    And I click on link "new_service_request"
    When I submit invalid service request
    Then I should be at the service requests page

  Scenario: Customer update created service order
  #Given an Valid User exists
    Given the following Valid user with account exists:
      | Account |
      | id:22   |
    And the following Valid Service Order exists:
      | Id | Customer Account |
      | 3  | Id: 22           |
    And log in last user
    When I am on the customer dashboard show page
    And I click on link "edit_service_order_3"
    And I click on button "update_service_order"
    Then I should be at the customer dashboard show page

#And a valid service exists





