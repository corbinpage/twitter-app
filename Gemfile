source 'https://rubygems.org'

gem 'sidekiq', '2.16.1'
gem 'sinatra', require: false
gem 'slim'
gem 'sqlite3'
gem 'less-rails-bootstrap'
gem 'webmock'
gem 'heroku'
gem 'capistrano', '2.15.5'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby
gem 'less-rails'

# Updating netssh gem version for deploy troubleshoot
gem 'net-ssh', '~> 2.7.0'

# Twitter Gem
gem 'twitter', '~>5.x'
gem 'twitter-text'

# Asynchronous Processing
# gem 'delayed_job_active_record'
# gem "daemons"

# OLD
# gem 'beanstalk-client'
# gem 'stalker'
# gem 'private_pub'
# gem 'thin'

# Profanity Checker
gem 'obscenity'

# Sentiment Analysis
gem 'sentimental'

# Google Maps gems
gem 'geocoder'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "better_errors"
  gem "sprockets_better_errors"
  gem "binding_of_caller"
  gem "factory_girl_rails"
  gem "simplecov"
  gem "database_cleaner"
  gem "pry"
end

group :production do
  gem "pg"
  gem "google-analytics-rails"
  # gem "rails_12factor"
end

gem "bootstrap-sass", "~> 3.1.1"
gem "figaro", github: 'laserlemon/figaro'
gem 'execjs'


