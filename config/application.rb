require_relative 'boot'

require 'rails/all'
require 'sprockets/es6'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lilu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.sass.preferred_syntax = :sass
    config.generators { |g| g.javascript_engine :js }

    I18n.available_locales = [:fr]
    I18n.default_locale = :fr
  end
end
