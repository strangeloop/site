class RateObserver < ActiveRecord::Observer
  include ProposalStatusUpdater

  def after_create(rate)
    update_proposal_status(rate.rateable) if rate.rateable.is_a? Proposal
  end
end


