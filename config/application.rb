require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ViksTnetica17
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    config.action_mailer.default_url_options = { host: 'ViksTnetica17.com' }

    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, 'redis://localhost:6379', { expires_in: 90.minutes }

    config.generators do |g|
      g.test_framework :rspec,
                        fixtures: true,
                        view_spec: false,
                        helper_specs: false,
                        routing_specs: false,
                        request_specs: false,
                        controller_spec: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
