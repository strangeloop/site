module Admin
  class SessionTimesController < Admin::BaseController

    cache_sweeper :clear_schedule_cache, :only => [:update, :destroy]
    
    crudify :session_time, :order => 'start_time ASC'

  end
end
