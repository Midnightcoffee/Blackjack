Given /^a user visits the lobby$/ do
  visit lobby_path
end

Then /^they should see an option to create a beginner game$/ do
  page.has_css?('.app-game-levels')
end

And /^a player stats widget.$/ do
  page.has_css?('.app-player-stats-widget')
end

