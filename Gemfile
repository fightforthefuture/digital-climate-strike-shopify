source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'rails', '~> 6.0.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5'
gem 'coffee-rails'
gem 'webpacker', '~> 4.0'
gem 'shopify_app'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'aws-sdk-s3', require: false
gem 'pg'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-byebug'
end

group :development do
  gem 'foreman'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'brakeman'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'reek'
  gem 'rspec-rails', '~> 3.8'
  gem 'fuubar', '2.2.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', '0.14.1', require: false, group: :test
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
