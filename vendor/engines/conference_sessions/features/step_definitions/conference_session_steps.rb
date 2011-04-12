Given /^I have no conference_sessions$/ do
  ConferenceSession.delete_all
end

Then /^I should have ([0-9]+) conference_sessions?$/ do |count|
  ConferenceSession.count.should == count.to_i
end
