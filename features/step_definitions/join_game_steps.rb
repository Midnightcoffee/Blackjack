When /^they click "Beginner"$/ do
  expect(false)
  #FIXME just link if only one game, other wise its a post.
end

Then /^they should be put into the game room.$/ do
  expect(page).to have_content("Bet")
end
