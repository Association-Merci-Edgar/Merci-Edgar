FactoryGirl.define do
  factory :contacts_import do
    contacts_file "MyString"
    first_name_last_name_order "MyString"
    test_mode "MyString"
    account
    user
  end
end
