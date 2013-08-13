# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    address "contact@foo.com"
    kind "Work"
  end
end
