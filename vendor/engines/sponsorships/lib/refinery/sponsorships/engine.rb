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
  module Sponsorships
    class Engine < Rails::Engine
      include Refinery::Engine

      config.after_initialize do
        Refinery.register_engine Refinery::Sponsorships
      end

      initializer 'init plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sponsorships"
          plugin.menu_match = /(admin|refinery)\/(sponsorships|sponsorship_levels)$/
          plugin.activity = {
            :class_name => 'Sponsorship'}
          plugin.url = Proc.new { Refinery::Core::Engine.routes.url_helpers.sponsorships_admin_sponsorships_path }
        end
      end
    end
  end
end
