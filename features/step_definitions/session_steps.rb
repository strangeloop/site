Given /^there are no conference sessions$/ do
  ConferenceSession.destroy_all
end

Then /^I should see a link with "([^"]*)" to "([^"]*)"$/ do |text, url|
  page.has_link?(text, :href => url).should be_true
end

Then /^I should see the (\w+) default speaker image$/ do |image_size|
  page.has_xpath?(".//img[@alt='Attendees#{image_size == 'small' ? '-small' : ''}']").should be_true
end

