require 'rails_helper'

describe "list contact", :type => :feature do

  it "show only venue from same account" do
    other_venue = FactoryGirl.create(:venue, account: FactoryGirl.create(:account))

    account = FactoryGirl.create(:account)
    Account.current_id = account.id
    user = FactoryGirl.create(:admin)
    login_as user
    my_venue = FactoryGirl.create(:venue, account: account)
    visit '/contacts'
    expect(page).to have_content 'Contacts'
    expect(page).to have_content my_venue.name
    expect(page).to_not have_content other_venue.name
  end
end
