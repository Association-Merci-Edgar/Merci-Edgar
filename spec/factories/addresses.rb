# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "Rue du Test"
    postal_code "75001"
    city "Paris"
    country "FR"
  end
end
