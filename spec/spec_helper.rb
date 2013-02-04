# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'factory_girl_rails'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'


  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false
    config.use_instantiated_fixtures = false

    # REVIEW: https://github.com/bmabey/email-spec - jaakko
    # config.include(EmailSpec::Helpers)
    # config.include(EmailSpec::Matchers)

    # config.infer_base_class_for_anonymous_controllers = false

    config.treat_symbols_as_metadata_keys_with_true_values = true
    # config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      #DatabaseCleaner.strategy = :transaction
    end

    # Selenium driver
    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
      DatabaseCleaner.clean
    end

    config.after(:each) do
    end
  end
end

Spork.each_run do

  # REVIEW: https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujitsu - jaakko
  # This code will be run each time you run your specs.
  FactoryGirl.reload
  I18n.backend.reload!

  # REVIEW: Using inmemory Sqlite3, we have to reload schema on each run - jaakko
  # ActiveRecord::Schema.verbose = false
  # load "#{Rails.root.to_s}/db/schema.rb"

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |_support_file| require _support_file }

  # Put your acceptance spec helpers inside spec/acceptance/support
  Dir[Rails.root.join("spec/acceptance/support/**/*.rb")].each { |_support_file| require _support_file }
end

# REVIEW: https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujitsu Devise - jaakko
Spork.trap_method(Rails::Application::RoutesReloader, :reload!)