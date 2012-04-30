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



require File.expand_path(File.dirname(__FILE__) + '/../../vendor/engines/proposals/spec/factories')

require 'factory_girl/step_definitions'

# Hack to gut AttendeeCred during cuke runs
if Rails.env == 'test'
  class AttendeeCred
    def self.default_cred=(attendee_cred)
      @@default_cred = attendee_cred
    end
    def self.authenticate_user(login, pass, event_id)
      @@default_cred
    end
  end
end

After do |scenario|
  if scenario.status == :failed
    save_and_open_page
  end
end

