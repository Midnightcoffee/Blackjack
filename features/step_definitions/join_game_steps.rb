
Given /^a user visits the blackjack game room$/ do
  visit '/main/current_game'  
end

When /^they click "join game"$/ do
  page.click_button("join game")
end

Then /^they should join the game$/ do
  #TODO 
end
  
