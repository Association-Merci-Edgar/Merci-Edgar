# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    transient do
      with_trial_period_account_expired false
      with_account_subscription_up_to_date true
      with_account_subscription_lasts_soon false
    end
    
    email { Faker::Internet.email}
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now

    after(:build) do |user, evaluator|
      if evaluator.with_trial_period_account_expired
        account = FactoryGirl.build(:account, created_at: Date.current - 1.month - 1.day)
      else
        if evaluator.with_account_subscription_up_to_date
          if evaluator.with_account_subscription_lasts_soon
            account = FactoryGirl.build(:account, last_subscription_at: Date.current - 1.year + 3.days)            
          else
            account = FactoryGirl.build(:account, last_subscription_at: Date.current - 6.months)
          end
        else 
          account = FactoryGirl.build(:account, last_subscription_at: Date.current - 1.year - 1.day)
        end
      end
      user.accounts = [account]
      FactoryGirl.build(:abilitation, user: user, account: account)
      user.add_role(:member)
    end

  end
  
  factory :admin, parent: :user do
    after(:build) do |user|
      user.add_role(:admin)
    end
  end
end
