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



Given /^there are no conference sessions$/ do
  ConferenceSession.destroy_all
end

Then /^I should see a link with "([^"]*)" to "([^"]*)"$/ do |text, url|
  page.has_link?(text, :href => url).should be_true
end

Then /^I should see the (\w+) default speaker image$/ do |image_size|
  page.has_xpath?(".//img[@alt='Attendees#{image_size == 'small' ? '-small' : ''}']").should be_true
end

