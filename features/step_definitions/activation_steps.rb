When /^I click on my activation url$/ do
  attendee = Factory(:attendee)
  visit path_to(activation_path(:token => attendee.activation_token))
end

Then /^I sign out$/ do
  visit '/attendee_creds/sign_out'
end

Then /^I click sign in$/ do
  visit '/attendee_creds/sign_in'
end

Then /^I fill in my email address$/ do
  fill_in("Email", :with => Attendee.first.email)
end

Given /^I fill in my registered email address$/ do
  fill_in 'Registration Email:', :with => Attendee.last.email
end


