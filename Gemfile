source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'thin', :group => :production


#gem 'rainbows'
gem 'less-rails-bootstrap'
gem 'jquery-rails'
gem 'bootstrap-datepicker-rails' #datepicker
gem 'simple_state_machine'
gem 'will_paginate'
gem 'inherited_resources'
gem 'simple_form'
gem 'erector', :git =>  "https://github.com/pivotal/erector.git" # view widgets
gem 'mini_record' # auto migration-
gem 'unicode_utils', :require => false
gem 'devise'
gem 'cancan'
gem 'meta_search'
gem "friendly_id", "~> 4.0.1"

gem 'sass-rails', '~> 3.2.3'
gem 'compass-rails'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'

end

group :db_seed do
  gem 'factory_girl'
  gem 'database_cleaner'
end

#============================================================================
# DEVELOPMENT
#============================================================================
group :development, :test do
  gem "factory_girl_rails", :require => false
  gem 'pry' # debug rails run => pry -r ./config/environment
  gem 'database_cleaner'
  gem "mailcatcher" #Get all mails on

  gem 'guard'
  #gem "rb-inotify"
  #gem 'libnotify'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'kss-rails' #builds css documentation https://github.com/kneath/kss
  gem 'capistrano'
end

#============================================================================
# TEST
#============================================================================
group :test do
  gem 'factory_girl', :require => false
  gem "factory_girl_rails", :require => false
  gem "rspec-rails", '2.7.0' # 2.8.0 Error with RedMine
  gem 'shoulda-matchers'
  gem 'rspec-html-matchers' #html match
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'pickle'
  gem "capybara"
  gem "guard-rspec"
  gem "guard-spork"
  #gem "rb-inotify"
  #gem 'libnotify'
  gem 'launchy'
  gem 'yajl-ruby'
  # run faster tests
  gem "spork", "> 0.9.0.rc"
  # Ubuntu apt-get install libqt4-dev
  # javascript headless test
  gem 'capybara-webkit'
  gem 'ruby-debug19', :require => 'ruby-debug'
end


