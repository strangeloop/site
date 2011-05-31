module Admin
  class SponsorshipsController < Admin::BaseController
    include ImageUploadFix

    prepend_before_filter :find_all_levels, :only => [:new, :edit]

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
  end
end
