# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheduling do
    scheduler nil
    show_host nil
    show_buyer nil
    period "MyString"
    style_tags "MyString"
  end
end
