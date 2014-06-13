Given /^a user visits the lobby$/ do
  visit '/'
end

Then /^they should see an option to create a beginner game$/ do
  page.find_link('Beginner').visible?
end

And /^a player stats widget.$/ do
  page.has_css?('.app-player-stats-widget')
end

