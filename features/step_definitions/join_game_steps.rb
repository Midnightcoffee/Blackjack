When /^they click "Beginner"$/ do
  page.choose("Beginner")
end

Then /^they should be put into the game room.$/ do
  expect(page).to have_text("Bet")
end
