# include JavaScriptHelpers

Given(/^I have visited the home page$/) do
  visit('http://www.google.com')
  find(:xpath,"//input[@title='Search']").set("manish")
  # wait_for_ajax
end

Then(/^it display "([^"]*)"$/) do |text|
  expect(page).to have_text text
end