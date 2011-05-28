require 'spec_helper'

describe "admin/proposals/index.html.erb" do
  before do
    view.stub(:searching?).and_return(false)
    assign(:proposals, [])
    Admin::ProposalsController.stub(:searchable?).and_return(false)
  end

  def role_check(val = false)
    checker = double('role_checker')
    checker.stub(:has_role?).with(:organizer).and_return(val)
    checker
  end

  it "hides export link for non-organizers" do
    view.stub(:current_user).and_return(role_check)
    render
    rendered.should_not =~ /Export Pending Proposals/
  end

  it "shows the Export Pending Proposals link for organizers" do
    view.stub(:current_user).and_return(role_check(true))
    render
    rendered.should =~ /Export Pending Proposals/
  end
end
