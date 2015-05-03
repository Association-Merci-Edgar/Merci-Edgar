Edgar::Application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.digest = true
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  config.assets.precompile += %w( jquery.js jquery_ujs contacts_index.js contacts.js tag.js contacts_form.js scheduling.js tasks_group.js simple/application.js onepage/application.js tour/home-tour-fr.js onepage.js onepage.css .svg .eot .woff .ttf multipage.css )


  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { :host => ENV['DOMAIN'] }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"

  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 25,
    :user_name => ENV["MANDRILL_USERNAME"],
    :password  => ENV["MANDRILL_API_KEY"]
  }

end
