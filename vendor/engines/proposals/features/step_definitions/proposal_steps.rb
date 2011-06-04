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



Given /^I have no proposals$/ do
  Proposal.delete_all
end

Given /^I (only )?have proposals titled "?([^\"]*)"?$/ do |only, titles|
  Proposal.delete_all if only
  titles.split(', ').each do |title|
    Proposal.create(:status => title)
  end
end

Then /^I should have ([0-9]+) proposals?$/ do |count|
  Proposal.count.should == count.to_i
end
