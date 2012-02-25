require 'spec_helper'

describe ProposalsController do
  #necessary because refinery serves admin creation page unless an admin acct exists
  login_admin

  context 'format is workshop' do
    describe '#new' do
      it 'renders the new_workshop template' do
        get :new, :format => 'workshop'
        response.should render_template('proposals/new_workshop')
      end
    end

    describe '#create' do
      context 'valid workshop and speaker data is submitted' do
        let(:mock_talk) { mock 'talk', :tap => self }
        let(:mock_email) { mock 'email', :deliver => nil }
        let(:talk_params) { ActiveSupport::HashWithIndifferentAccess.new :title => 'F', :abstract => 'a', :talk_type => 'Intro',
                              :speakers_attributes => { '0' => { :first_name => 'm', :last_name => 'a',
                                                           :email => 'a@a.com', :bio => 'a' }} }
        let(:params) { {:proposal => {:talk_attributes => talk_params, :format => 'workshop' }} }

        before do
          Talk.stub(:new => mock_talk)
          mock_talk.stub(:save => true, :tap => mock_talk)
          Proposal.stub(:create)
          SpeakerMailer.stub_chain(:talk_submission_email, :deliver)
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
          SpeakerMailer.should_receive(:talk_submission_email).with(mock_talk).and_return(mock_email)
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
    it 'renders the new_talk template' do
      get :new, :format => 'talk'
      response.should render_template('proposals/new_talk')
    end
  end
end
