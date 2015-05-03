require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Edgar
  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'


      g.view_specs false
      g.helper_specs false
    end

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/extras)

    config.time_zone = 'Paris'

    config.i18n.default_locale = :fr
    config.i18n.locale = :fr

    config.encoding = "utf-8"

    config.filter_parameters += [:password, :password_confirmation]

    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true

    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.initialize_on_precompile = false

    config.to_prepare do
      Devise::RegistrationsController.layout "onepage"
      Devise::SessionsController.layout "simple"
      Devise::PasswordsController.layout "simple"
    end
  end
end
