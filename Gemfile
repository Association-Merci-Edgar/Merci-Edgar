source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'gibbon'
gem 'haml-rails'
gem 'rolify'

gem 'simple_form'
gem 'nested_form'
gem 'country_select'
gem 'activevalidators'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'gmaps4rails'
gem 'geocoder'

gem 'thin'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'awesome_print'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end

group :production do
  gem 'pg'
end
