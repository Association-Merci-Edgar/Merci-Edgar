require 'rails_helper'

describe "Signin", :type => :feature do

  it "doesnt work when user not exist" do
    visit root_path
    click_button "Se connecter"
    fill_in "user_email", with: "henri@ford.com"
    fill_in "user_password", with: "myUbbbberPass"
    click_button "Se connecter"
    expect(page).to have_content("Email ou mot de passe invalide.")
  end

  it "work with a valid user" do
    user = FactoryGirl.create(:admin)
    Account.current_id = user.accounts.first.id
    visit root_path
    click_button "Se connecter"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Se connecter"
    expect(page).to have_content("C'est aujourd'hui gratuit")
  end

  it "doesnt work whit the wrong email" do
    user = FactoryGirl.create(:admin)
    visit root_path
    click_button "Se connecter"
    fill_in "user_email", with: "fake@mail.com"
    fill_in "user_password", with: user.password
    click_button "Se connecter"
    expect(page).to have_content("Email ou mot de passe invalide.")
  end

  it "doesnt work whit the wrong password" do
    user = FactoryGirl.create(:admin)
    visit root_path
    click_button "Se connecter"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "Faillllllpass"
    click_button "Se connecter"
    expect(page).to have_content("Email ou mot de passe incorrect.")
  end


end

