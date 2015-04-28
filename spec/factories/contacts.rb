# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    phone "MyString"
    email "MyString"
    street "MyString"
    postal_code "MyString"
    city "MyString"
    country "MyString"
  end
<<<<<<< HEAD
  
  factory :contact_attributes, class: Hash do
    adresse "1 impasse du Cottage"
    code_postal "77200"
    ville "Torcy"
    web "www.example.com"
    tel "01 60 37 69 83"
    email "contact@example.com"
    reseaux "Reggae Guilde, Passion Pro"
    tags_perso "à contacter, faire recherche"    
    observations "Il est possible qu'ils ferment ..."
  end
=======
>>>>>>> master
end
