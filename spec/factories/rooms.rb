# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    name "MyString"
    depth 1.5
    width 1.5
    height 1.5
    bar false
    venue nil
  end
end
