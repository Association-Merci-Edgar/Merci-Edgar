When(/^I visit the new venue page$/) do
  visit new_venue_path(:locale => :fr)
end

Then(/^I should see the new venue page$/) do
  page.should have_content "New venue"
end