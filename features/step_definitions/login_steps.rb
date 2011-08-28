Then /^I should see login via (\w+) link$/ do |service|
  page.has_link?('', :href => external_auth_path(:provider => service.downcase)).should be_true
end

