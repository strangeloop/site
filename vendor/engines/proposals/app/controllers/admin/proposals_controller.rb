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



module Admin
  class ProposalsController < Admin::BaseController
    expose(:proposal)
    expose(:current_proposals) { proposals_for_format.paginate({:page => params[:page], :per_page => 10})}
    expose(:session_times) { SessionTime.current_year }
    expose(:format) { params[:format] || 'talk' }
    expose(:format_name) { format.capitalize.pluralize }

    before_filter(:only =>[:rate, :add_comment]) do
      redirect_to(root_path) unless current_user.has_role? :reviewer
    end

    before_filter(:only => [:export]) do
      redirect_to(root_path) unless current_user.has_role? :organizer
    end

    crudify :proposal,
            :title_attribute => 'status', :order => 'created_at DESC'

    def rate
      @proposal = proposal.tap do |proposal|
        proposal.rate(params[:stars], current_user, params[:dimension])
        #the reload is needed in case the status changed,
        #I wish this could be more elegant
        proposal.reload
      end
      @params = params
    end

    def proposals_for_format
      if (format == 'talk')
        Proposal.current.talk
      elsif (format == 'workshop')
        Proposal.current.workshop
      else
        []
      end
    end

    def add_comment
      proposal.comments.create(:comment => params[:comment], :user => current_user)
      #the reload is needed in case the status changed,
      #I wish this could be more elegant
      proposal.reload
      @comment = params[:comment]
      @status = proposal.status
    end

    def proposal_update
      if accepted?
        approve_proposal
      elsif rejected?
        reject_proposal
      else
        @proposal = proposal
        render :edit
      end
    end

    def export
      respond_to do |format|
        format.csv { render :xml => Proposal.all_to_csv }
      end
    end

    private
    def accepted?
      params[:status] == 'accepted'
    end

    def rejected?
      params[:status] == 'rejected'
    end

    def send_email
      params[:sendmail] == '1'
    end

    def approve_proposal
      conf_param = params[:conference_session]
      if conf_param
        update_proposal_status
        session_time = SessionTime.find(conf_param[:session_time_id])
        talk = proposal.talk
        conf_session = ConferenceSession.create(:talk => talk, :session_time => session_time)

        SpeakerMailer.talk_accepted_email(talk, session_time).deliver if send_email

        redirect_to :action => :index
      else
        @proposal = proposal
        proposal.errors.add :you, 'must select a session time'
        render :edit
      end
    end

    def reject_proposal
      update_proposal_status
      SpeakerMailer.talk_rejected_email(proposal.talk).deliver if send_email

      redirect_to :action => :index
    end

    def update_proposal_status
      proposal.update_attribute :status, params[:status]
    end
  end
end
