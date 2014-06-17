Given /^a user visits the lobby$/ do
  visit '/'
end

# Then /^they should see an option to create a beginner game$/, js: true do
#   expect(page).to have_text("Beginner")
# end

# And /^a player stats widget.$/ do
#   expect(page).to have_text("Total Chips:")
# end

# And /^that player stats widget shows his total chip count.$/ do 
#   player = Player.first 
#   player.total_chips = 0
#   expect(page).to have_text?(player.total_chips)
#   page.has_text?(0)
# end
