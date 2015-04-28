# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    first_name "MyString"
    last_name "MyString"
    account nil
  end
<<<<<<< HEAD
  factory :person_attributes, class:Hash do
    nom "Jean-Pierre Dusse"
    first_name_last_name_order "first_name"
  end
=======
>>>>>>> master
end
