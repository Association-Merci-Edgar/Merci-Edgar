# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contacts_import do
    contacts_file "MyString"
    first_name_last_name_order "MyString"
    test_mode "MyString"
    account_id 1
    user_id 1
  end
end
