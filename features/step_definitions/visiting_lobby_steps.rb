Given /^a user visits the lobby$/ do
  visit '/'
end

Then /^they should see an option to create a beginner game$/ do
  page.has_link?('Beginner')
end

And /^a player stats widget.$/ do
  page.has_css?('.app-player-stats-widget')
end

