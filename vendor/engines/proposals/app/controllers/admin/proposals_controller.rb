module Admin
  class ProposalsController < Admin::BaseController
    before_filter(:only => [:rate, :add_comment]) do
      redirect_to(root_path, :status => 401) unless current_user.has_role? :reviewer
    end

    crudify :proposal,
            :title_attribute => 'status'

    def rate
      @proposal = Proposal.find(params[:id])
      @proposal.rate(params[:stars], current_user, params[:dimension])
      @params = params
      #the reload is needed in case the status changed, 
      #I wish this could be more elegant
      @proposal.reload
    end

    def add_comment
      proposal = Proposal.find(params[:id])
      proposal.comments.create(:comment => params[:comment], :user => current_user)
      @comment = params[:comment]
      #the reload is needed in case the status changed, 
      #I wish this could be more elegant      
      proposal.reload
      @status = proposal.status
    end

    def update_proposal_status(id, status)
      proposal = Proposal.find(id)
      proposal[:status] = status
      proposal.save
      proposal
    end

    def approve_proposal
      proposal = update_proposal_status(params[:id], "accepted")
      ConferenceSession.create(:talk => proposal.talk)
      SpeakerMailer.talk_accepted_email(proposal.talk).deliver
      redirect_to :action => :index
    end

    def reject_proposal
      proposal = update_proposal_status(params[:id], "rejected")
      SpeakerMailer.talk_rejected_email(proposal.talk).deliver
      redirect_to :action => :index
    end
    
    def export
      respond_to do |format|      
        format.csv { render :xml => Proposal.pending_to_csv() }
      end
    end
  end
end
