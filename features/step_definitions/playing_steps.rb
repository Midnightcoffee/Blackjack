Given /^a user visits the game page$/ do
  visit game_path 
end

When /^they take a hit$/ do
  click_button "hit"
end

#  TODO: check pre-state and post state s.t count_was = count_is -1
Then /^they should get a card$/ do
  page.has_css(".app-game-player-card", count => 3)
end

Then /^they shouldnt get a card$/ do
  page.has_css(".app-game-player-card", count => 4)
end
