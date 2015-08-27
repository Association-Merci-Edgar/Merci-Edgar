# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :structure do
    contact

    trait :generic do
      structurable_type nil
      structurable_id nil
    end
  end
end
