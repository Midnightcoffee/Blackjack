Given /^the player exists$/ do
  expect(Player.count).to eql(1)
end

Given /^they visit the lobby$/ do
  visit '/'
end

Then /^they should see an options to join a game.$/ do
  expect(page).to have_text("Beginner")
  expect(page).to have_text("Intermediate")
  expect(page).to have_text("High Roller")
end

And /^a player stats widget.$/ do
  expect(page).to have_text("Total Chips:")
end

And /^that player stats widget shows his total chip count.$/ do 
  expect(page).to have_text(100)
end


