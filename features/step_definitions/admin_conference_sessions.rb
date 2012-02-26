Given /^there are conference sessions for the current and previous years$/ do
  Factory(:talk_session)
  Factory(:last_years_talk_session)
end

Then /^I should see the current the current year's session$/ do
  page.should have_css("div#records li", :count => 1)
end

Then /^I should see a link to view sessions from the previous year$/ do
  page.should have_link("Manage Conference Sessions from #{Time.now.year - 1}")
end

