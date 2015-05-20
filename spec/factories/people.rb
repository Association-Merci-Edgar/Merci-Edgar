FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end

  factory :person do
    first_name { FactoryGirl.generate(:name) }
    last_name { FactoryGirl.generate(:name) }
  end

end
