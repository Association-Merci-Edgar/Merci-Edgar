require 'database_cleaner'
require 'faker'

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
  end
  config.before(:each) do
    DatabaseCleaner.start
    Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 2.years)
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
