module Admin
  class ConferenceSessionsController < Admin::BaseController

    prepend_before_filter :fix_image,
                          :only => [:create, :update]

    crudify :conference_session

    def index
      search_all_conference_sessions if searching?
      paginate_all_conference_sessions

      render :partial => 'conference_sessions' if request.xhr?
    end

    def new
      @conference_session = ConferenceSession.new(:talk => Talk.new(:speakers => [Speaker.new]))
    end

    def fix_image
      image_param = params[:conference_session][:talk_attributes][:speakers_attributes]["0"].delete(:image)
      if image_param
        image = Image.new(image_param)
        image.save
        params[:conference_session][:talk_attributes][:speakers_attributes]["0"][:image] = image
      end
    end

    def export
      respond_to do |format|
        format.csv { render :xml => ConferenceSession.to_csv(params[:year]) }
      end
    end
  end
end
