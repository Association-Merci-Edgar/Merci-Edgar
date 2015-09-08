FactoryGirl.define do
  factory :account do
    name "Test account"
    domain { FactoryGirl.generate(:domain_name) }
    trait :with_trial_period_account_expired do
      created_at Date.current - 1.month - 1.day
    end
    trait :with_account_subscription_up_to_date do
      last_subscription_at Date.current - 6.months
    end
    trait :with_account_subscription_lasts_soon do
      last_subscription_at Date.current - 1.year + 3.days
    end
    trait :with_account_subscription_not_up_to_date do
      last_subscription_at Date.current - 1.year - 1.day
    end
  end

  sequence :domain_name do |n|
    "testaccount#{n}"
  end
end
