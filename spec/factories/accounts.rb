FactoryGirl.define do
  factory :account do
    name "Test account"
    domain { FactoryGirl.generate(:domain_name) }
  end

  sequence :domain_name do |n|
    "testaccount#{n}"
  end
end
