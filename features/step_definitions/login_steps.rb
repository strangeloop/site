Then /^I should see login via (\w+) link$/ do |service|
  page.has_link?('', :href => external_auth_path(:provider => service.downcase)).should be_true
end

Then /^I should not see login via (\w+) link$/ do |service|
  page.has_link?('', :href => external_auth_path(:provider => service.downcase)).should be_false
end

Then /^I should see login via Google activation link$/ do
  page.has_link?('', :href => external_auth_path(:google, :token => Attendee.last.acct_activation_token)).should be_true
end

