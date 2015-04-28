# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :festival do
    nb_edition 1
    last_year 1
    artists_kind "MyString"
<<<<<<< HEAD
    account
  end
  
  factory :festival_attributes, class:Hash do
    nom "Festoche Reggae"
    nb_editions 2
    derniere_annee 2013
  end
  
=======
    account_id 1
  end
>>>>>>> master
end
