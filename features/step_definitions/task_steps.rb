# encoding: utf-8
Etantdonné(/^(?:|que je|je) suis connecté$/) do
  @user = FactoryGirl.create(:confirmed_user)
  sign_in(@user)
  Account.current_id = @user.accounts.first.id
end

Etantdonné(/^(?:|que je|je) regarde la fiche d'une salle$/) do
  v = FactoryGirl.create(:venue)
  visit venue_path(v, :locale => :fr)
end

Lorsque(/^(?:|que je|je) clique sur "(.*?)"$/) do |link|
  click_link(link)
end

Lorsque(/^(?:|que je|je) donne "(.*?)" comme (.*?)$/) do |value, field|
  fill_in field, with: value
end

Lorsque(/^(?:|que je|je) remplis "(.*?)" par "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

Lorsque(/^(?:|que je|je) choisis "(.*?)" comme (.*?)$/) do |value, field|
  pending # express the regexp above with the code you wish you had
end

Lorsque(/^que je clique sur le bouton "(.*?)"$/) do |button|
  clibk_button(button)
end

Alors(/^je devrais voir "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
