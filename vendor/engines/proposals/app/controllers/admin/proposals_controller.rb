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
    before_filter(:only => [:rate, :add_comment]) do
      redirect_to(root_path) unless current_user.has_role? :reviewer
    end

    before_filter(:only => [:export]) do
      redirect_to(root_path) unless current_user.has_role? :organizer
    end

    before_filter(:only => [:edit]) do
      @session_times = SessionTime.current_year
    end

    crudify :proposal,
            :title_attribute => 'status', :order => 'created_at DESC'

    def rate
      @proposal = Proposal.find(params[:id]).tap do |proposal|
        proposal.rate(params[:stars], current_user, params[:dimension])
        #the reload is needed in case the status changed, 
        #I wish this could be more elegant
        proposal.reload
      end
      @params = params
    end

    def add_comment
      proposal = Proposal.find(params[:id]).tap do |proposal|
        proposal.comments.create(:comment => params[:comment], :user => current_user)
        #the reload is needed in case the status changed,
        #I wish this could be more elegant
        proposal.reload
      end
      @comment = params[:comment]
      @status = proposal.status
    end

    def proposal_update
      send_mail = params[:sendmail] == "1"
      if params[:approve]
        approve_proposal(send_mail)
      elsif params[:reject]
        reject_proposal(send_mail)
      end
    end

    def export
      respond_to do |format|
        format.csv { render :xml => Proposal.all_to_csv }
      end
    end

    private
    def approve_proposal(send_email)
      proposal = update_proposal_status("accepted")
      session_time = SessionTime.find(params[:conference_session][:session_time_id])
      talk = proposal.talk
      conf_session = ConferenceSession.create(:talk => talk, :session_time => session_time)

      SpeakerMailer.talk_accepted_email(talk, session_time).deliver if send_email

      redirect_to :action => :index
    end

    def reject_proposal(send_email)
      proposal = update_proposal_status("rejected")

      SpeakerMailer.talk_rejected_email(proposal.talk).deliver if send_email

      redirect_to :action => :index
    end

    def update_proposal_status(status)
      Proposal.find(params[:id]).tap do |proposal|
        proposal.status = status
        proposal.save
      end
    end
  end
end
