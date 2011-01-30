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
        end
      end
    end
  end
end
