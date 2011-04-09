Given /^there are no conference sessions$/ do
  ConferenceSession.destroy_all
end

Then /^I should see a link with "([^"]*)" to "([^"]*)"$/ do |text, url|
  page.has_link?(text, :href => url).should be_true
end

