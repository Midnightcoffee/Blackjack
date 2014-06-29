When /^they click "Beginner"$/ do
  click_link("Beginner")
end

Then /^they should be put into the game room.$/ do
  expect(page).to have_button("Bet")
end

Then(/^they should NOT see the option to stand$/) do
  expect(page).to have_no_button("Stand")
end

Then(/^they should NOT see the option to hit$/) do
  expect(page).to have_no_button("Hit")
end

