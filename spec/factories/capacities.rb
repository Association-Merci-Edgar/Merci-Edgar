# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :capacity do
    nb 1
    kind "MyString"
    venue nil
  end
end
