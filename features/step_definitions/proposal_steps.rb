Given /^the following proposals:$/ do |proposals|
  Proposal.create!(proposals.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) proposal$/ do |pos|
  visit proposals_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following proposals:$/ do |expected_proposals_table|
  expected_proposals_table.diff!(tableish('table tr', 'td,th'))
end
