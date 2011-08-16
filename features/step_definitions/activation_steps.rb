When /^I click on my activation url$/ do
  attendee = Factory(:attendee)
  visit path_to(activation_path(:token => attendee.activation_token))
end

