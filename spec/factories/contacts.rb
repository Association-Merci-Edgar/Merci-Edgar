FactoryGirl.define do
  factory :contact do
    name { FactoryGirl.generate(:contact_name) }
  end

  sequence :contact_name do |n|
    "name_contact_#{n}"
  end
end
