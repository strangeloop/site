module Admin
  class SponsorshipsController < Admin::BaseController
    include ImageUploadFix

    prepend_before_filter :find_all_levels, :only => [:new, :edit]
    prepend_before_filter :resolve_sponsorship_level, :only => [:create, :update]

    crudify :sponsorship, :xhr_paging => true

    def new
      @sponsorship = Sponsorship.new(:contact => Contact.new, :sponsor => Sponsor.new)
    end

    #callback invoked by ImageUploadFix
    def image_in_params(params)
      params[:sponsorship][:sponsor_attributes]
    end

    def find_all_levels
      @levels = SponsorshipLevel.all
    end

    def resolve_sponsorship_level
      level = SponsorshipLevel.find(params['sponsorship']['sponsorship_level'].to_i)
      params['sponsorship']['sponsorship_level'] = level
    end
  end
end
