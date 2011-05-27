Given /^I have no sponsorships$/ do
  Sponsorship.delete_all
end


Then /^I should have ([0-9]+) sponsorships?$/ do |count|
  Sponsorship.count.should == count.to_i
end
