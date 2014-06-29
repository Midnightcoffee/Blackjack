Then(/^they should be able to stand$/) do 
  find_button("Stand").trigger('click')
end

Then /^they should see the option to bet$/ do
  expect(page).to have_button("Bet")
end
