require 'rails_helper'

describe "Inscription", :type => :feature do

  it "quand tout va bien" do
    visit root_path
    within('#cta-enroll') do
      fill_in 'user_email', with: 'henri@ford.com'
      click_button "Je m'inscris !"
    end

    expect(page).to have_content("Bienvenue chez Edgar ! Faisons les présentations !")

    fill_in 'user_first_name', with: 'Henri'
    fill_in 'user_last_name', with: 'Ford'
    fill_in 'user_password', with: 'myUberPass'
    fill_in 'user_password_confirmation', with: 'myUberPass'
    fill_in 'user_label_name', with: 'mycompany'

    click_button "C'est parti !"
    expect(page).to have_content("Bienvenue ! Mot de passe oublié ? Se souvenir de moi")
    expect(User.count).to eq(1)
    expect(User.first.email).to eq('henri@ford.com')
    expect(Account.count).to eq(1)
  end

  it "quand l'email n'est pas valide" do
    visit root_path
    within('#cta-enroll') do
      fill_in 'user_email', with: 'henri'
      click_button "Je m'inscris !"
    end

    expect(page).to have_content("Bienvenue chez Edgar ! Faisons les présentations !")

    fill_in 'user_first_name', with: 'Henri'
    fill_in 'user_last_name', with: 'Ford'
    fill_in 'user_password', with: 'myUberPass'
    fill_in 'user_password_confirmation', with: 'myUberPass'
    fill_in 'user_label_name', with: 'mycompany'

    click_button "C'est parti !"
    expect(page).to have_content("Informations non sauvegardées Email n'est pas valide Pour plus de sécurité, utilisez 8 caractères ou plus avec au moins 1 chiffre")
    expect(User.count).to eq(0)
  end

end

