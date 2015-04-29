def test_tmp_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'tmp/test', *paths))
end

def spreadsheet_samples_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'files', *paths))
end

def merge_attributes(*args)
  attributes = {}
  args.each { |arg| attributes.merge!(FactoryGirl.attributes_for(arg)) }
  attributes[:imported_at] = Time.zone.now.to_i
  attributes.with_indifferent_access
end

def get_model(klass, row, *args)
  row.merge!(*args) if args.present?
  model_instance, invalid_keys = klass.from_csv(row)
  model_instance.save!
  model_instance
end

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
