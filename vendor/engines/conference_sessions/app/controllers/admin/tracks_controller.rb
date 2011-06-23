module Admin
  class TracksController < Admin::BaseController

    crudify :track, :order => 'conf_year DESC'

  end
end
