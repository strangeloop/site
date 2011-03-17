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
  end
end
