# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    address "MyString"
    location "MyString"
    contact_data nil
  end
end
