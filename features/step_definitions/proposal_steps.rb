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



When /^I approve the proposal$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^there are no submitted talks$/ do
  Proposal.destroy_all  
end

Transform /^table:title,by,status$/ do |table|
  table.hashes.map do |hash|
    talk = Factory.create(:talk, :title => hash[:title])
    name = hash[:by].split(' ')
    speaker = Factory.create(:speaker, :first_name => name.first, :last_name => name.last)
    proposal = Proposal.new :status => hash[:status]
    {:talk => talk, :speaker => speaker, :proposal => proposal}
  end
end

Transform /^table:title,by,abstract,bio,av req,approve video,talk type,status$/ do |table|
  table.hashes.map do |hash|
    talk = Factory.create(:talk, 
                          :title          => hash[:title],
                          :abstract       => hash[:abstract],
                          :av_requirement => hash[:"av req"],
                          :video_approval => hash[:"approve video"],
                          :talk_type      => hash[:"talk type"])
    name = hash[:by].split(' ')
    speaker = Factory.create(:speaker, 
                             :first_name => name.first, 
                             :last_name => name.last,
                             :bio => hash[:bio])
    proposal = Proposal.new :status => hash[:status]
    {:talk => talk, :speaker => speaker, :proposal => proposal}
  end
end

Given /^the following talks have been submitted:$/ do |table|
  table.each do |group|
    talk = group[:talk]
    talk.speakers = [ group[:speaker] ]
    talk.save
    proposal = group[:proposal]
    proposal.talk = talk
    proposal.save
  end
end

When /^I rate the proposal with (\d+) stars$/ do |rating|
  click_link rating
end

Then /^the default proposal should have a (\d+) out of (\d+) star rating$/ do |rating, maximum|
  page.should have_content("Your rating: #{rating} out of #{maximum}")
end

Given /^the proposal was rated with (\d+) star[s]? by (.*)$/ do |stars, reviewer|
  Proposal.first.rate(stars.to_i, User.find_by_username(reviewer), 'appeal')
end

def check_email(body)
  speaker = Factory(:speaker)
  ActionMailer::Base.deliveries.size.should == 1
  email = ActionMailer::Base.deliveries[0]
  email.to[0].should == speaker.email
  email.body.include?(body).should be_true
  ActionMailer::Base.deliveries.clear
end

And /^a congrats email should be sent to the submitter$/ do
  check_email "Congrats"
end

And /^a rejection email should be sent to the submitter$/ do
  ActionMailer::Base.deliveries.delete_at 0
  check_email "isn't a good fit"
end


Given /^a comment "([^"]*)" was added to the proposal by (.*)$/ do |comment, reviewer|
  Proposal.first.tap{|p| p.comments.create(:comment => comment, :user => User.find_by_username(reviewer))}.save
end




