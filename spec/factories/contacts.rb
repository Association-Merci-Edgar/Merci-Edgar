# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    phone "MyString"
    email "MyString"
    street "MyString"
    postal_code "MyString"
    city "MyString"
    country "MyString"
  end
end
