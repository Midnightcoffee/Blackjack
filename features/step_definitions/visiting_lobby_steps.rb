Given /^a user visits the lobby$/ do
  visit '/'
end

Then /^they should see an options to join a game.$/ do
  expect(page).to have_text("Beginner")
  expect(page).to have_text("Intermediate")
  expect(page).to have_text("High Roller")
end

And /^a player stats widget.$/ do
  #TODO: should this be something else?
  expect(page).to have_text("Total Chips:")
end

And /^that player stats widget shows his total chip count.$/ do 
  #TODO better way to stub this
  player = Player.find(1)
  player.total_chips = 0
  expect(page).to have_text(player.total_chips)
  expect(page).to have_text(0)
end
