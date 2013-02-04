# -*- encoding : utf-8 -*-

When /^I choose "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within(selector) do
    page.choose(value)
  end
end
When /^I choose "([^"]*)"$/ do |value|
  page.choose(value)
end
When /^I select "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within("##{@form_id}") do
    page.select value, :from => "#{@model_name}[#{selector}]"
  end
end

When /^save and open page$/ do
  page.save_and_open_page
end

When /^within form (.*)$/ do |model|
  @model_name = model.gsub(' ', '_')
  @form_id = "form##{@model_name}, form#new_#{@model_name}, form#edit_#{@model_name}" if @model_name
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |selector, value|
  @form_id ||= 'form'
  @selector =  @model_name ? "#{@model_name}[#{selector}]" : selector
  within(@form_id) do
    page.fill_in(@selector, :with => value)
  end
end
Then /I submit form/ do
  within(@form_id) do
    find('input[type=submit], button.btn-primary').click
  end
end
When /^I click on button "(.*)"$/ do |value|
    page.click_button(value)
end

When /^I click on link "(.*)"$/ do |value|
    page.click_link(value)
end

Then /^I should see notice message with "([^"]*)"$/ do |msg|
  page.within('div.alert-message.info') do |t|
    #  page.has_content?('niddc')
    page.text.should include(msg)
    #page.has_content?(msg).should be_true
  end
end

Then /^I should see preview message with "([^"]*)"$/ do |msg|
  page.within('div.alert-message.block-message') do |t|
    page.text.should include(msg)
  end
end

Then /^I should see within "(.*)" message "(.*)"$/ do |tag, msg|
  page.within(tag) do
    page.text.should include(msg)
  end
end

When /^the last #{capture_model} created$/ do |model_name|
  instance = find_model(model_name)
  puts instance.inspect
end

When /^I follow "([^"]*)"$/ do |name|
  page.click_link(name)
end