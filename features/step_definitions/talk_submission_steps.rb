When /I enter a talk/ do
  visit path_to("the new talks page")
 
  fill_in "talk_title",  :with => "Solar Powerd Flux Capacitors"
  fill_in "abstract", :with => "A HOWTO on constructing a solar powered flux capacitor"
  
  click_button "Create Talk"
end
Given /^a refinery user exists$/ do
  Factory(:refinery_user)
end

When /^(?:|I )select "([^"]*)"(?: in "([^"]*)")?$/ do |item, box|
  select(item, :from => box)
end

When /^an email should be sent$/ do
  !ActionMailer::Base.deliveries.size.should == 1
end

Given /^I change the (\w*) field to "([^"]*)"$/ do |field_name, content|
  page.fill_in field_name, :with => content
end

When /^I push the (\w*) button$/ do |button_text|
  page.click_button button_text
end

Then /^I should see the (\w*) field with "([^"]*)"$/ do |field_name, content|
  page.has_field?(field_name, :with => content).should be_true
end
