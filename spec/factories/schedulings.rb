# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheduling do
    scheduler nil
    show_host nil
    show_buyer nil
    period "MyString"
    style_tags "MyString"
  end

  factory :scheduling_attributes, class:Hash do
    styles "reggae, fusion"
    contrats "Cession"
    decouverte "x"
    observations_programmation "Très pointu"
    mois_prospection "1..3, 9..11"    
  end
    
end
