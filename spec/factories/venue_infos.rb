# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue_info do
    depth 1.5
    width 1.5
    height 1.5
    kind "MyString"
  end
end
