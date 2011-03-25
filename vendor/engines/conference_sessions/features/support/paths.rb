module NavigationHelpers
  module Refinery
    module ConferenceSessions
      def path_to(page_name)
        case page_name
        when /the list of conference_sessions/
          admin_conference_sessions_path

         when /the new conference_session form/
          new_admin_conference_session_path
        else
          nil
        end
      end
    end
  end
end
