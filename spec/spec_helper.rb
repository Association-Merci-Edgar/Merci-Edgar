RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
