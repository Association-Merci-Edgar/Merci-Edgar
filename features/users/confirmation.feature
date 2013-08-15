@javascript
Feature: Confirmation
  As an unconfirmed user
  I want to confirm my account 
  so I can beta test Merci Edgar

  Scenario: User confirms with valid data
    Given I am not logged in
    When I visit the home page
    And I follow the first "Je veux le tester !"
    When I fill in "Email" with "example@example.com"
    And I click a button "Demande d'invitation"
    Then I should see a message "Merci"
    Given I am logged in as an administrator
    And I visit the users page
    
    When I click a link "send invitation"
    Then I should see "resend"
    When I open the email with subject "Confirmation instructions"
    Then I should see "confirm your email address" in the email body

  
    Given I am not logged in
    When I follow "Confirm my account" in the email
    And I fill in "Nom d'utilisateur" with "krichtof"
    And I fill in "Prénom" with "Christophe"
    And I fill in "Nom" with "Robillard"
    And I fill in "Nom de votre association, label, groupe..." with "Tubercules"
    And I fill in "Choisissez un mot de passe" with "blabla11"
    And I fill in "Répétez votre mot de passe" with "blabla11"
    And I click a button "C’est parti !"
    Then the user "krichtof" should belong to account "Tubercules"
    And "Tubercules" account should have domain "tubercules"

