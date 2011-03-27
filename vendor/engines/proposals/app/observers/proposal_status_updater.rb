module ProposalStatusUpdater
  def update_proposal_status(proposal)
    if (proposal.status == 'submitted')
      proposal.status = 'under review'
      proposal.save
    end
  end
end

