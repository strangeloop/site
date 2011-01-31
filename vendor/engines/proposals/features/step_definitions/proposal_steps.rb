Given /^I have no proposals$/ do
  Proposal.delete_all
end

Given /^I (only )?have proposals titled "?([^\"]*)"?$/ do |only, titles|
  Proposal.delete_all if only
  titles.split(', ').each do |title|
    Proposal.create(:status => title)
  end
end

Then /^I should have ([0-9]+) proposals?$/ do |count|
  Proposal.count.should == count.to_i
end
