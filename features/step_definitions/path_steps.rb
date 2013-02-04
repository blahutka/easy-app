#Then(/^(.+?) should match route (\/.*)$/) do |page, route|
#  regexp = route.gsub(/:(\w*?)id/,'\d+')
#  path_to(page).should =~ /#{regexp}/
#end
#
#When(/^I go to (.+)$/) do |page|
#  visit path_to(page)
#end
#

Then(/^I should be at (the .+)$/) do |page|

  if page
    #begin
      current_path.should eq path_to(page)
    #rescue
    #  current_path.should eq path_to("the #{page}")
    #end
    #else if page =~ /#{capture_model}'s/
    #  find_model!($1)
    #  current_url.should eq url_for(model($1))
  #else
   # current_path.should eq path_to("the #{page}")
  end
end
#Then /^I am on the #{capture_model}'s page$/ do |model_name|
#  model =  model_name.gsub(' ', '_').camelize.constantize.last
#  current_path.should == post_comments_path(post)
#end
#
Given(/^I am on (.+)$/) do |page|
  visit path_to(page)
end