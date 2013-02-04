Given /^I submit (\d) service requests in "([^"]*)" with "([^"]*)"$/ do |num, input, value|
  num.to_i.times do
    steps %Q{
          Given I am on the home page
          When within form service_request
          And I fill in "#{input}" with "#{value}"
          And I click on button "Submit"
          Then I should see within "h2" message "#{value}"
        }
  end
end

Given /^I submit service request in "([^"]*)" with "([^"]*)"$/ do |input, value|

  steps %Q{
          Given I am on home page
          When within form service_request
          And I fill in "#{input}" with "#{value}"
          And I click on button "Submit"
          Then I should see within "h2" message "#{value}"
        }
end

Given /^I submit (.*) service request/ do |status|
  service_request = build(:"#{status}_service_request")
  service_request.should send(:"be_#{status}")
  submit_service_request(service_request)
  #step 'the valid service request exist'
end

module ServiceRequestWorld
  def submit_service_request(factory)
    within 'form#new_service_request, form#edit_service_request' do
      fill_in 'service_request[serial_num]', :with => factory.serial_num
      click_on 'submit_service_request'
    end
  end
end

World(ServiceRequestWorld)