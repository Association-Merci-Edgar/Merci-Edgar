require 'rails_helper'

describe "Edit user", :type => :feature do

  it "works" do
    account = FactoryGirl.create(:account, domain: "tesst")
    Account.current_id = account.id
    user = FactoryGirl.create(:admin, accounts: [account])
    login_as user

    Capybara.app_host = "http://#{user.accounts.first.domain}.lvh.me"

    visit edit_user_path(user, locale: :fr)
    expect(page).to have_content("L’image doit peser moins de 100 Ko")
  end

end

