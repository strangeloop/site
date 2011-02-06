require 'refinery'

module Refinery
  module Proposals
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "proposals"
          plugin.activity = {
            :class => Proposal,
            :title => 'status'
          }

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
