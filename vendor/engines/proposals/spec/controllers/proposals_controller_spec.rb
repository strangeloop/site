require 'spec_helper'

describe ProposalsController do
  #necessary because refinery serves admin creation page unless an admin acct exists
  login_admin

  shared_examples_for "proposal format" do |proposal_format|
    context 'CFP expired' do
      describe '#new' do
        before { RefinerySetting.set("#{proposal_format}_proposals_accepted".to_sym, 'false') }

        it 'renders the cfp_expired template' do
          get :new, :format => proposal_format
          response.should render_template("proposals/cfp_expired")
        end
      end
    end

    context 'CFP open' do
      describe '#new' do
        before { RefinerySetting.set("#{proposal_format}_proposals_accepted".to_sym, 'true') }
        it 'renders the new template' do
          get :new, :format => proposal_format
          response.should render_template("proposals/new_#{proposal_format}")
        end
      end
    end
  end

  context 'format is workshop' do

    it_should_behave_like "proposal format", "workshop"

    describe '#create' do
      context 'valid workshop and speaker data is submitted' do
        let(:mock_talk) { mock 'talk', :tap => self }
        let(:mock_email) { mock 'email', :deliver => nil }
        let(:talk_params) { ActiveSupport::HashWithIndifferentAccess.new :title => 'F', :abstract => 'a',
          :speakers_attributes => { '0' => { :first_name => 'm', :last_name => 'a',
                                                           :email => 'a@a.com', :bio => 'a' }} }
        let(:params) { {:proposal => {:talk_attributes => talk_params, :format => 'workshop' }} }

        before do
          Talk.stub(:new => mock_talk)
          mock_talk.stub(:save => true, :tap => mock_talk)
          Proposal.stub(:create)
          SpeakerMailer.stub_chain(:send, :deliver)
        end

        it 'creates a new talk' do
          Talk.should_receive(:new).with(talk_params).and_return(mock_talk)
          mock_talk.should_receive(:tap).and_return(mock_talk)
          post :create, params
        end

        it 'saves the talk' do
          mock_talk.should_receive(:save).and_return(true)
          post :create, params
        end

        it 'creates a proposal' do
          Proposal.should_receive(:create).with(:status => 'submitted', :talk => mock_talk, :format => 'workshop')
          post :create, params
        end

        it 'sends an email to the speaker' do
          SpeakerMailer.should_receive(:send).with("workshop_submission_email", mock_talk).and_return(mock_email)
          mock_email.should_receive(:deliver)
          post :create, params
        end

        it 'renders the create_workshop template' do
          post :create, params
          response.should render_template(:create_workshop)
        end
      end

      context 'invalid workshop data is submitted' do
        it 'renders the new_workshop template' do
          post :create, :format => :workshop
          response.should render_template(:new_workshop)
        end
      end
    end
  end

  context 'format is talk' do
    it_should_behave_like "proposal format", "talk"
  end

  context 'format is elc' do
    it_should_behave_like "proposal format", "elc"
  end
end
