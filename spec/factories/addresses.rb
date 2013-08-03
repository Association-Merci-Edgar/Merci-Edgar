# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "MyString"
    postal_code "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    location "MyString"
    contact_data nil
  end
end
