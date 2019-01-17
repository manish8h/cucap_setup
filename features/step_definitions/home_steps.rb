Given(/^I have visited the home page$/) do
  visit('http://www.google.com')
end

Then(/^it display "([^"]*)"$/) do |text|
  expect(page).to have_text text
end