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

