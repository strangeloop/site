Given /^I have no conference_sessions$/ do
  ConferenceSession.delete_all
end

Given /^I (only )?have conference_sessions titled "?([^\"]*)"?$/ do |only, titles|
  ConferenceSession.delete_all if only
  titles.split(', ').each do |title|
    ConferenceSession.create(:title => title)
  end
end

Then /^I should have ([0-9]+) conference_sessions?$/ do |count|
  ConferenceSession.count.should == count.to_i
end
