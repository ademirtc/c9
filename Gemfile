source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '1.3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use json library
gem 'json'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rake'

#Use as powerful configuration library and automatic merging of coverage across test suites
gem 'simplecov', :require => false, :group => :test
#Use as BDD for Ruby
#gem 'rspec'
#----------
gem 'rspec'
gem 'rquad', '~> 0.2.0'
#----------




group :development, :test do
  #Use as testing framework for Rails 3.x and 4.x.
  gem 'rspec-rails', '>= 2.8.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  #Is a generator that generates and modifies files in a Rails project so it can be used with Cucumber
  gem 'cucumber-rails', :require => false
  #gem 'cucumber-rails', '>= 1.2.1'
  #Capybara helps you test web applications by simulating how a real user would interact with your app.
  gem 'capybara', '>= 1.1.2'
  #Driver for Capybara. It allows you to run your Capybara tests on a headless WebKit browser
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  #gem 'database_cleaner'
  #Launchy is helper class for launching cross-platform applications in a fire and forget manner.
  gem 'launchy'
end

group :production do
  #Makes running Rails app easier. Based on the ideas behind 12factor.net
  gem 'rails_12factor'
  gem 'pg' # for Heroku deployment
end

#
#gem 'therubyracer', '>= 0.9.9'

#Railsstrap integrates Bootstrap and FontAwesome for Rails Asset Pipeline
gem 'railsstrap'
#Provides integration for Rails projects using the Less stylesheet language in the asset pipeline.
gem 'less-rails'


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development