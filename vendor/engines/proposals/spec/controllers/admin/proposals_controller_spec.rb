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

describe Admin::ProposalsController do

  it "by creation date descending" do
    Admin::ProposalsController.should_receive(:crudify).with(:proposal, {:title_attribute => 'status', :order => 'created_at DESC'})
    load(File.join(File.dirname(__FILE__),'..','..','..','app', 'controllers','admin', 'proposals_controller.rb'))
  end

  context 'role checking' do
    login_admin

    it "ensures the current user has the reviewer role before allowing rating" do
      post :rate, :id => 1, :format => 'js'
      assigns[:proposal].should be_nil
      response.should redirect_to(root_path)
    end

    it "redirects if non-organizers try to call export" do
      get :export, :format => 'csv'
      response.should redirect_to(root_path)
    end
  end

  let(:proposal) { mock_model(Proposal).as_null_object }
  let(:talk) { mock_model(Talk).as_null_object }

  context 'approved proposal update' do
    login_admin

    let(:approval_params) do
      { :status => 'accepted',
        :conference_session => { :session_time_id => 1 },
        :id => 2 }
    end

    let(:proposal_approval) do
      post :proposal_update, approval_params
    end

    let(:proposal_approval_email) do
      post :proposal_update, approval_params.merge(:sendmail => '1')
    end

    let(:session_time) { mock_model(SessionTime).as_null_object }

    before do
      Proposal.stub(:find).with(2).and_return(proposal)
      SessionTime.stub(:find).with(1).and_return(session_time)
      ConferenceSession.stub(:create).with(:talk => talk, :session_time => session_time)
      proposal.should_receive(:talk).and_return(talk)
    end

    it "updates the proposal status to 'accepted'" do
      proposal.should_receive(:update_attribute).with(:status, 'accepted')

      proposal_approval

      response.should redirect_to(admin_proposals_path)
    end

    it "sends approval email optionally" do
      mailer_mock = mock('mailer')
      mailer_mock.should_receive :deliver
      SpeakerMailer.stub(:talk_accepted_email).with(talk, session_time).and_return(mailer_mock)

      proposal_approval_email
    end
  end

  context "rejection proposal update" do
    login_admin

    let(:rejection_options) do
      {:status => 'rejected', :id => 1}
    end

    let(:proposal_rejection) do
      post :proposal_update, rejection_options
    end

    let(:proposal_rejection_email) do
      post :proposal_update, rejection_options.merge(:sendmail => "1")
    end

    before do
      Proposal.stub(:find).with(1).and_return(proposal)
    end

    it "updates the proposal status to 'rejected'" do
      proposal.should_receive(:update_attribute).with(:status, 'rejected')

      proposal_rejection

      response.should redirect_to(admin_proposals_path)
    end

    it "sends rejection email optionally" do
      proposal.should_receive(:talk).and_return(talk)
      mailer_mock = mock('mailer')
      mailer_mock.should_receive :deliver
      SpeakerMailer.stub(:talk_rejected_email).with(talk).and_return(mailer_mock)

      proposal_rejection_email
    end
  end

  context "export action" do
    login_organizer

    it "exports proposals to CSV" do
      Proposal.stub(:all_to_csv).and_return('a, b, c')
      get :export, :format => 'csv'
      response.body.should == 'a, b, c'
    end
  end
end
