require 'rails_helper'

describe "Create a venue", :type => :feature do

  it "simple" do
    account = FactoryGirl.create(:account)
    Account.current_id = account.id
    user = FactoryGirl.create(:admin)
    login_as user

    visit new_structure_path
    expect(page).to have_content 'Contacts'
    expect(page).to have_content 'Lieu'
  end
end

