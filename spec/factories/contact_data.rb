# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_datum, :class => 'ContactDatum' do
    after(:build) do |c|
      c.addresses = [FactoryGirl.build(:address)]
      c.phones = [FactoryGirl.build(:phone)]
      c.websites = [FactoryGirl.build(:website)]
      c.emails = [FactoryGirl.build(:email)]
    end
  end
end
