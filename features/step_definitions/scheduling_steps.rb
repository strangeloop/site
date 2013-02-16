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


Given /^there are no rooms$/ do
  Room.destroy_all
end

Given /^there are no session times$/ do
  SessionTime.destroy_all
end

Given /^there are no tracks$/ do
  Track.destroy_all
end

Given /^schedule details are configured to be hidden$/ do
  Refinery::Setting.set(:hide_schedule_details, 'true')
end

Then /^I should see "([^"]*)" as a link to the schedule page$/ do |link_text|
  page.has_link?(link_text, :href => schedule_path).should be_true
end

Then /^I see the come back later message$/ do
  page.should have_content('The schedule for the next Strange Loop conference has not yet been announced.')
end

