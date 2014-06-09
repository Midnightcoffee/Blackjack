Given /^a user visits the game page$/ do
  visit game_path 
end


When /^they take a hit$/ do
  click_button "hit"
end

Then /^they should get a card$/ do
  #TODO: check model vs check html? Both are needed not sure
  # if cucumber should handle both. Or if the test should
end
