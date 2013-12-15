# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :festival do
    nb_edition 1
    last_year 1
    artists_kind "MyString"
    account_id 1
  end
end
