Given(/^a player joins intermediate game$/) do
  visit '/#/games/2'
end

When(/^they bet within the correct limits$/) do
  fill_in("Amount", :with => 75)
  find_button("Bet").trigger('click')

end
Then(/^they should NOT see their bet$/) do
  expect(page).to have_no_text('75')

end

Then(/^they should see their intermediate bet$/) do
  expect(page).to have_text('75')
end

Then(/^their intermediate bet should be placed$/) do
  @game = Game.find(2)
  expect(@game.player_bet).to eq(75)
end

Then(/^they should see their intermediate cards$/) do
  @game = Game.find(2)
  expect(page).to have_text(@game.player_hand)
  #FIXME make sure its under player cards element or something
  expect(page).to have_text("Diamond,Jack")
  expect(page).to have_text("Diamond,5")
end

Then(/^they should see the intermediate dealers card$/) do
  @game = Game.find(2)
  #FIXME: should be just one card, currently to make it easier i'm only
  #FIXME: decouple from deck
  expect(page).to have_text(@game.dealer_hand)
  expect(page).to have_text("Diamond,10")
  expect(page).not_to have_text("Club,5")
end

Then(/^their bet should NOT be placed$/) do
  @game = Game.find(2)
  expect(@game.player_bet).to eq(0)
end



