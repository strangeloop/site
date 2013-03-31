module Refinery
  module Admin
    class TracksController < Refinery::AdminController

      cache_sweeper :clear_schedule_cache, :only => [:update, :destroy]

      crudify :track, :order => 'conf_year DESC'

    end
  end
end
