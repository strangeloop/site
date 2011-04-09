module Admin
  module ProposalsHelper
    def title_for(proposal)
      proposal.talk.title
    end
  end  
end
