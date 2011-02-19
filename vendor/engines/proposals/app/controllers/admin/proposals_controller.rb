module Admin
  class ProposalsController < Admin::BaseController

    crudify :proposal,
            :title_attribute => 'status'

    def rate
      @proposal = Proposal.find(params[:id])
      @proposal.rate(params[:stars], current_user, params[:dimension])
      @params = params
    end
  end
end
