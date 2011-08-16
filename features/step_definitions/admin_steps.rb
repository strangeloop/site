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



def login
  visit new_user_session_path
  fill_in("user_login", :with => @user.email)
  fill_in("user_password", :with => 'greenandjuicy')
  click_button("submit_button")
end

Given /^I am a logged in (\w+\s?\w*)$/ do |role|
  @user ||= Factory(role.gsub(' ', '_').to_sym)
  login
end

Given /^I am logged in as an attendee$/ do
  @user ||= Factory(:attendee).user
  login
end

Then /^I should see "([^"]*)" as a link to the login page$/ do |link_text|
  page.has_link?(link_text, :href => new_user_session_path).should be_true
end

Then /^I should see "([^"]*)" as a link to the logout page$/ do |link_text|
  page.has_link?(link_text, :href => destroy_user_session_path).should be_true
end

