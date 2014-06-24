When /^they click "Beginner"$/ do
  find("#app-game-level-Beginner").click
end

Then /^they should be put into the game room.$/ do
  expect(page).to have_content("Bet")
end
