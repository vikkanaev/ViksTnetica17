source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
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
gem 'responders'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'cancancan', '~> 2.0'
gem 'doorkeeper'
gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

# gem 'delayed_job_active_record'
gem 'sidekiq'
gem 'redis'
gem 'whenever'

gem 'mysql2'
gem 'thinking-sphinx'

gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'
gem 'therubyracer'
gem 'unicorn'
gem 'redis-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rubocop-rails'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'pry-rails'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '>= 2.0.0'

  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-unicorn', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'json_spec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
