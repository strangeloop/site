#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



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
