Given(/^a player joins a game$/) do
  visit '/#/games/1'
end

When(/^they bet$/) do
  fill_in("Amount", :with => 25)
  find_button("Bet").trigger('click')
end

#TODO: add a flash message - better UX

Then(/^they should see their bet$/) do
  @game = Game.find(1)
  expect(page).to have_text('25')

end
Then(/^their bet should be placed$/) do
  @game = Game.find(1)
  expect(@game.player_bet).to eq(25)  
end

Then(/^they should see their cards$/) do
  @game = Game.find(1)
  expect(page).to have_text(@game.player_hand)
  #FIXME make sure its under player cards element or something
  expect(page).to have_text("Diamond,Jack")
  expect(page).to have_text("Diamond,5")
end

Then(/^they should see the dealers card$/) do
  @game = Game.find(1)
  #FIXME: should be just one card, currently to make it easier i'm only
  #FIXME: decouple from deck
  expect(page).to have_text(@game.dealer_hand)
  expect(page).to have_text("Diamond,10")
  expect(page).not_to have_text("Club,5")
end


Then(/^they should see the option to stand$/) do
  expect(page).to have_button("Stand")
end

Then(/^they should see the option to hit$/) do
  expect(page).to have_button("Hit")
end

Then(/^they should NOT see the option to bet$/) do
  expect(page).to have_no_button("Bet")
end


