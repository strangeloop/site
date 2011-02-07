def login
  visit new_user_session_path
  fill_in("user_login", :with => @user.email)
  fill_in("user_password", :with => 'greenandjuicy')
  click_button("submit_button")
end

Given /^I am a logged in reviewer$/ do
  @user ||= Factory(:reviewer)
  login
end

Given /^there are no submitted talks$/ do
  Proposal.destroy_all  
end

Transform /^table:title,by,track,status$/ do |table|
  table.hashes.map do |hash|
    talk = Factory.create(:talk, :title => hash[:title])
    name = hash[:by].split(' ')
    speaker = Factory.create(:speaker, :first_name => name.first, :last_name => name.last)
    track = Factory.create(:track, :abbrev => hash[:track])
    proposal = Proposal.new :status => hash[:status]
    {:talk => talk, :speaker => speaker, :track => track, :proposal => proposal}
  end
end

Given /^the following talks have been submitted:$/ do |table|
  table.each do |group|
    talk = group[:talk]
    talk.speakers = [ group[:speaker] ]
    talk.track = group[:track]
    talk.save
    proposal = group[:proposal]
    proposal.talk = talk
    proposal.save
  end
end

