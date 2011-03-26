module Admin
  class ProposalsController < Admin::BaseController

    crudify :proposal,
            :title_attribute => 'status'

    def rate
      return unless current_user.has_role? :reviewer
      @proposal = Proposal.find(params[:id])
      @proposal.rate(params[:stars], current_user, params[:dimension])
      @params = params
    end

    def add_comment
      @proposal = Proposal.find(params[:proposal_id])
      @proposal.comments.create(:comment => params[:comment], :user => current_user)
      @proposal.save
      render "edit"
    end

    def update_proposal_status(id, status)
      proposal = Proposal.find(id)
      proposal[:status] = status
      proposal.save
      proposal
    end

    def approve_proposal
      update_proposal_status(params[:id], "accepted")
      redirect_to :action => :index
    end

    def reject_proposal
      update_proposal_status(params[:id], "rejected")
      redirect_to :action => :index
    end
  end
end
