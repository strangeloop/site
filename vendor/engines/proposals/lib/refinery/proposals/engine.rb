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
  module Proposals
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Proposals

      config.after_initialize do
        Refinery.register_engine Refinery::Proposals
      end

      initializer 'init plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.name = "proposals"
          plugin.activity = {
            :class_name => 'Proposal',
            :title => 'status'
          }
          plugin.url = Proc.new { Refinery::Core::Engine.routes.url_helpers.admin_proposals_path }

          class <<plugin
            alias old_title title
            def title
              pending = Proposal.pending_count
              return "#{old_title} (#{pending})" unless pending == 0
              old_title
            end
          end
        end
      end
    end
  end
end
