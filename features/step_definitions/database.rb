Then /^I should find the following for the last (.*):$/ do |model, table|
  model_class = model.camelize.constantize
  last_instance = model_class.last or raise "No #{model.pluralize} exist"
  table.hashes.first.each do |key, value|
    #puts'='*20
    last_instance.attributes.has_key?(key) or raise "No table column '#{key}' exist"
    last_instance.attributes[key].to_s.should == value
  end
end

Then /^there should be (\d+) (.*)$/ do |count, model|
  model_class = model.singularize.camelize.constantize
  model_class.count.should == count.to_i
end