module Admin
  class SponsorshipLevelsController < Admin::BaseController

    crudify :sponsorship_level, :xhr_paging => true

  end
end

