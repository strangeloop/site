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


module Refinery
  module ConferenceSessions
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::ConferenceSessions

      config.after_initialize do
        Refinery.register_engine Refinery::ConferenceSessions
      end

      initializer 'init plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.name = "conference_sessions"
          plugin.menu_match = /(admin|refinery)\/(conference_sessions|rooms|session_times|tracks)$/
          plugin.activity = {class_name: 'ConferenceSession'}
          plugin.url = Proc.new { Refinery::Core::Engine.routes.url_helpers.admin_conference_sessions_path }
        end
      end
    end
  end
end
