Given /^there are no conference sessions$/ do
  ConferenceSession.destroy_all
end

Then /^I should see (\d+) conference session$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

