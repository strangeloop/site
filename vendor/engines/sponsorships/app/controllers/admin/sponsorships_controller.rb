module Admin
  class SponsorshipsController < Admin::BaseController
    prepend_before_filter :find_all_levels, :only => [:new]
    prepend_before_filter :resolve_sponsorship_level, :only => [:create]

    crudify :sponsorship, :xhr_paging => true

    def new
      @sponsorship = Sponsorship.new(:contact => Contact.new, :sponsor => Sponsor.new)
    end

    def find_all_levels
      @levels = SponsorshipLevel.all
    end

    def resolve_sponsorship_level
      level = SponsorshipLevel.find(params['sponsorship']['level'])
      params['sponsorship']['level'] = level
    end
  end
end
