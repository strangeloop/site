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


