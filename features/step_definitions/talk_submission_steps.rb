#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



Given /^a refinery user exists$/ do
  Factory(:refinery_user)
end

Given /^the (\w+) cfp is open$/ do |talk_format|
  RefinerySetting::set("#{talk_format}_proposals_accepted".to_sym, 'true')
end


Given /^the period for submitting (\w+) proposals has expired$/ do |talk_format|
  RefinerySetting::set("#{talk_format}_proposals_accepted".to_sym, 'false')
end

Given /^I change the (\w+\s?\w*) field to "([^"]*)"$/ do |field_name, content|
  page.fill_in field_name, :with => content
end

Given /^I change the (\w+\s?\w*) select to "([^"]*)"$/ do |field_name, content|
  page.select content, :from => field_name
end

When /I enter a talk/ do
  visit path_to("the new talks page")

  fill_in "talk_title",  :with => "Solar Powerd Flux Capacitors"
  fill_in "abstract", :with => "A HOWTO on constructing a solar powered flux capacitor"

  click_button "Create Talk"
end

When /^(?:|I )select "([^"]*)"(?: in "([^"]*)")?$/ do |item, box|
  select(item, :from => box)
end

When /^an email should be sent$/ do
  ActionMailer::Base.deliveries.size.should == 1
end

When /^I push the (\w*) button$/ do |button_text|
  page.click_button button_text
end

When /^I try to create a new (\w+) proposal$/ do |talk_format|
  visit new_proposal_of_path(talk_format)
end

Then /^I should see the (\w+\s?\w*) field with "([^"]*)"$/ do |field_name, content|
  page.has_field?(field_name, :with => content).should be_true
end

Then /^I visit (.*)$/ do |path|
  visit path_to(path)
end

Then /^I see a message that the (\w+) proposal period has expired$/ do |talk_format|
  page.should have_content "The call for #{talk_format} proposals has expired."
end


