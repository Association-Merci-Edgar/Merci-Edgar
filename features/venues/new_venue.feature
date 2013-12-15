Feature: Create a venue
  In order to manage venues
  The users
  Should be able to create their own venues

Scenario: A form is available to create a venue
  Given I am logged in
  When I visit the new venue page
  Then I should see the new venue page