module NavigationHelpers
  module Refinery
    module Sponsorships
      def path_to(page_name)
        case page_name
        when /the list of sponsorships/
          admin_sponsorships_path

         when /the new sponsorship form/
          new_admin_sponsorship_path
        else
          nil
        end
      end
    end
  end
end
