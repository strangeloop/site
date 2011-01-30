module NavigationHelpers
  module Refinery
    module Proposals
      def path_to(page_name)
        case page_name
        when /the list of proposals/
          admin_proposals_path

         when /the new proposal form/
          new_admin_proposal_path
        else
          nil
        end
      end
    end
  end
end
