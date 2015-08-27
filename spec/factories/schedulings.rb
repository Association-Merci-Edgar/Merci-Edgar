# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheduling do
    name "Mandatory Name"
    scheduler nil
    show_host nil
    show_buyer nil
    period Scheduling::QUATERLY
    style_tags "MyString"
  end
end
