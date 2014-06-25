When /^they click "Beginner"$/ do
  click_link("Beginner")
end

Then /^they should be put into the game room.$/ do
  expect(page).to have_content("bet")
end
