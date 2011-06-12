module Admin
  class SessionTimesController < Admin::BaseController

    crudify :session_time, :order => 'start_time ASC'

  end
end
