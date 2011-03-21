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
