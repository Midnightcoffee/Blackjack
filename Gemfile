source 'https://rubygems.org'
ruby '2.1.2'
#ruby-gemset=blackjack_4_0

gem 'rails', '4.0.5'
gem 'pg'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'
gem 'haml-rails', '~> 0.5.3'

group :production do
  gem 'rails_12factor'
end

group :test, :development do
  gem 'selenium-webdriver', '~> 2.42.0'
  gem 'fabrication', '2.11.2'
  gem 'cucumber-rails', '~> 1.4.1', require: false
  gem 'database_cleaner', '~> 1.3.0' 
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'konacha', '~> 3.2.3'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'factory_girl_rails'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end
