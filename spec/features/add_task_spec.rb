require 'rails_helper'

describe "Create a task", :type => :feature do

  it "work when linked with a room" do
    account = FactoryGirl.create(:account, domain: "tesst")
    Account.current_id = account.id
    user = FactoryGirl.create(:admin, accounts: [account])
    login_as user

    Capybara.app_host = "http://#{user.accounts.first.domain}.lvh.me"

    venue = FactoryGirl.create(:venue)
    visit venue_path(venue, locale: :fr)
    expect(page).to have_content(venue.name)
    expect(page).to have_content(user.name)
    expect(page).to have_selector('#plusmenu-trigger', visible: true)

    click_link "une tâche"

    within('#new_task') do
      fill_in 'task_name', with: 'Une tache pour voir'
      click_button 'Créer'
    end

    Account.current_id = account.id
    expect(Task.count).to eq(1)
    expect(Task.first.name).to eq("Une tache pour voir")
    expect(page).to have_content("Une tache pour voir")
  end
end

