Given(/^a player joins a game$/) do
  visit '/#/games/1'
end

When(/^they bet$/) do
  fill_in "Bet-Amount", :with => 20
  click_button("Bet")
end

Then(/^their bet should be placed$/) do
  @game = Game.find(1)
  expect(@game.player_bet).to equal(20) 
end

Then(/^they should see their cards$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^they should see the dealers card$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^see the option to hold$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^see the option to hit$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^not see the option to bet$/) do
  pending # express the regexp above with the code you wish you had
end

