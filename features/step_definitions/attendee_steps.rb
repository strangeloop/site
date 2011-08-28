Then /^I should see "([^"]*)" as a link to the iCal download$/ do |link_text|
  page.has_link?(link_text, :href => attendee_path(Attendee.first, :format => :ics)).should be_true
end

