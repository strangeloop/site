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
  end
end
