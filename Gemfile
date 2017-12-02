source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
#gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'pg', '~> 0.21.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'slim-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'turbolinks'

gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'remotipart'
gem 'cocoon'
gem 'gon'
gem 'skim'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rubocop-rails'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'pry-rails'
  gem 'database_cleaner'
  gem 'capybara-webkit'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '>= 2.0.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
