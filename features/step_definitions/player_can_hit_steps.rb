Then(/^they should be able to hit$/) do
  find_button("Hit").trigger('click')
end

Then(/^they should see their card$/) do
  #TODO: better test needed probable implies better modeling needed
  #expect(page).to have_selector('.card', :count => 3)
  expect(page).to have_text('|', :count => 4)
end

Then(/^they should NOT see their card$/) do
  expect(page).to have_text('|', :count => 3)
end

