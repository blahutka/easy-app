# -*- encoding : utf-8 -*-

Given /^customer user is logged in$/ do
  steps %Q{
   Given a valid user exists
   And I am on the users sign in page
   When within form user
   And I fill in "email" with "customer@easyservice.cz"
   And I fill in "password" with "password"
   And I click on button "Sign in"
   Then I should be at the customer dashboard show page
  }
end

When /^I am logged out$/ do
  #session.reset!
  visit root_path
  find_link('Sign in')
end
When /^I log in$/ do
  step "I am logged in"
end

Then /^I should see my name (.*)$/ do |my_name|
  page.find('a#account').text.should include(my_name)
end

Given /I am logged as #{capture_model}$/ do |user_model|
  @current_user = FactoryGirl.create(user_model)
  login_as(@current_user, :scope => :user)

  #session["warden.user.user.key"] = User.serialize_into_session(user)
end

Given /log in last user/ do
  last_user = find_model('the user')#User.current or raise "No current_user found"
  login_as(last_user, :scope => :user)
end