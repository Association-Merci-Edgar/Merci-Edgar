require 'rails_helper'

describe "Signout", :type => :feature do

  it "work with a valid user" do
    account = FactoryGirl.create(:account, domain: "tesst")
    Account.current_id = account.id
    user = FactoryGirl.create(:admin, accounts: [account])
    Capybara.app_host = "http://#{user.accounts.first.domain}.lvh.me"
    login_as user

    visit welcome_path
    page.find('*[title=Déconnexion]').click
    expect(page).to have_content("Déconnecté.")
  end

end

