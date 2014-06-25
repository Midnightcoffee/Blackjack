Given /^the player and games exists$/ do
  expect(Player.count).to eql(1)
  expect(Game.count).to eql(3)
end

Given /^they visit the lobby$/ do
  visit '/'
end

Then /^they should see an options to join a game.$/ do
  expect(page).to have_link("Beginner")
  expect(page).to have_link("Intermediate")
  expect(page).to have_link("High Roller")
end

And /^a player stats widget.$/ do
  expect(page).to have_text("Total Chips:")
end

And /^that player stats widget shows his total chip count.$/ do 
  expect(page).to have_text(100)
end


