module Admin
  class ProposalsController < Admin::BaseController

    crudify :proposal,
            :title_attribute => 'status'

  end
end
