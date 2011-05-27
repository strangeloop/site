require 'refinerycms-base'

module Refinery
  module Sponsorships
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sponsorships"
          plugin.menu_match = /(admin|refinery)\/(sponsorships|sponsorship_levels)$/
          plugin.activity = {
            :class => Sponsorship}
        end
      end
    end
  end
end
