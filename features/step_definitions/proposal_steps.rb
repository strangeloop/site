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

Transform /^table:title,by,abstract,bio,av req,approve video,talk type,length,status$/ do |table|
  table.hashes.map do |hash|
    talk = Factory.create(:talk, 
                          :title          => hash[:title],
                          :abstract       => hash[:abstract],
                          :av_requirement => hash[:"av req"],
                          :video_approval => hash[:"approve video"],
                          :talk_type      => hash[:"talk type"],
                          :talk_length    => hash[:length])
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

Given /^the proposal was rated with (\d+) star[s]? by "([^"]*)"$/ do |stars, reviewer|
  Proposal.first.rate(stars.to_i, User.find_by_username(reviewer), 'appeal')
end

