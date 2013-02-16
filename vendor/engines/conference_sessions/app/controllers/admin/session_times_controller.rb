require_relative '../../sweepers/clear_schedule_cache'

module Admin
  class SessionTimesController < Refinery::AdminController

    cache_sweeper :clear_schedule_cache, :only => [:update, :destroy]

    crudify :session_time, :order => 'start_time ASC'

  end
end
