#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



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
    view.stub(:format).and_return('talk')
    view.stub(:format_name).and_return('Talks')
    view.stub(:tracks).and_return([])
    view.stub(:current_proposals).and_return([])
    render
    rendered.should_not =~ /Export Proposals/
  end

  it "shows the Export Pending Proposals link for organizers" do
    view.stub(:current_user).and_return(role_check(true))
    view.stub(:format).and_return('talk')
    view.stub(:format_name).and_return('Talks')
    view.stub(:tracks).and_return([])
    view.stub(:current_proposals).and_return([])
    render
    rendered.should =~ /Export Proposals/
  end
end
