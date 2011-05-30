module Admin
  class ConferenceSessionsController < Admin::BaseController
    include ImageUploadFix

    crudify :conference_session

    def index
      search_all_conference_sessions if searching?
      paginate_all_conference_sessions

      render :partial => 'conference_sessions' if request.xhr?
    end

    def new
      @conference_session = ConferenceSession.new(:talk => Talk.new(:speakers => [Speaker.new]))
    end

    #callback invoked by ImageUploadFix
    def image_in_params(params)
      params[:conference_session][:talk_attributes][:speakers_attributes]["0"]
    end

    def export
      respond_to do |format|
        format.csv { render :xml => ConferenceSession.to_csv(params[:year]) }
      end
    end
  end
end
