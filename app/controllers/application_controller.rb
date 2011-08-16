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



# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.

class ApplicationController < ActionController::Base

  expose(:current_attendee) { Attendee.find_by_user_id(current_user.id) if current_user }

end
