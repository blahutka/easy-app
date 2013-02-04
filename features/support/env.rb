require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] = 'cucumber'
  require 'cucumber/rails'
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment') unless defined?(Rails)

  Capybara.default_selector = :css

  # DOESN'T WORK HERE added to environment/cucumber.rb
  #Capybara.asset_root = Rails.root.join('public/cucumber/')

  # PRECOMPILE TO WORK WITH save_and_open_page
  # %x[bundle exec rake assets:precompile]

  #Capybara.current_driver = :selenium
  ActionController::Base.allow_rescue = false
  Cucumber::Rails::Database.javascript_strategy = :truncation


  begin
    require 'pry'
    require 'database_cleaner'
    require 'database_cleaner/cucumber'
    DatabaseCleaner.strategy = :truncation
    Cucumber::Rails::World.use_transactional_fixtures = false
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

end

Spork.each_run do
  require 'factory_girl'
  require 'factory_girl_rails'
  World FactoryGirl::Syntax::Methods

end


# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  #DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as tCucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#



