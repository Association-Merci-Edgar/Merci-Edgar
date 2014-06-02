FactoryGirl.define do
  
  factory :people_structure_attributes, class:Hash do
    first_name_last_name_order "first_name"
    nom_programmateur "Jean-Pierre Dusse"
    email_programmateur "jp@festochereggae.com"
    web_programmateur "www.jpdusse.com"
    nom_regisseur "Yvan Trop"
    email_regisseur "yvan@trop.com"
    web_regisseur "www.example.com"
    tel_regisseur "+33 1 02 03 04 05"
  end    

end