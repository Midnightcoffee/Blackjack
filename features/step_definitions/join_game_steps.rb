When /^they click "Beginner"$/ do
  page.choose("Beginner")
end

Then /^they should join the game$/ do
  #FIXME: current the player starts off as playing the game
  #so this test is a bit of a lie.
  player = Player.first
  expect(player.game.id).to eql(1)
end

And /^they should be put into the game room$/ do
  #TODO check something else?
  expect(page).to have_text("Bet")
end

