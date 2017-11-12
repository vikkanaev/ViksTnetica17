require 'rails_helper'

RSpec.configure do |config|
  # lets roll
  Capybara.javascript_driver = :webkit
  config.use_transactional_fixtures = false
  config.include AcceptanceMacros, type: :feature
  config.include WaitForAjax, type: :feature

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
