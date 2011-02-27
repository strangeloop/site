module Admin
  module ProposalsHelper
    def title_for(proposal)
      proposal.talk.title
    end

    def speaker_for(proposal)
      speaker = proposal.talk.speakers.first
      "#{speaker.first_name} #{speaker.last_name}"
    end
  
    def track_for(proposal)
      proposal.talk.track
    end

    def display_for(role)
      yield if current_user.has_role? role
    end
  end  
end
