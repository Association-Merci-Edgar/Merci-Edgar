# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email}
    factory :confirmed_user, parent: :user do
      password 'changeme'
      password_confirmation 'changeme'
      # required if the Devise Confirmable module is used
      confirmed_at Time.now
      after(:build) do |user|
        user.accounts = [FactoryGirl.build(:account)]
      end
    end
  end
end
