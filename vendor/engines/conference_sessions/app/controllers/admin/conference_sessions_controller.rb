module Admin
  class ConferenceSessionsController < Admin::BaseController

    crudify :conference_session

    def index
      search_all_conference_sessions if searching?
      paginate_all_conference_sessions

      render :partial => 'conference_sessions' if request.xhr?
    end

    def update
      conf = ConferenceSession.find(params[:id])
      image_param = params[:conference_session][:talk_attributes][:speakers_attributes]["0"].delete(:image)
      if image_param
        image = Image.new(image_param)
        image.save
        params[:conference_session][:talk_attributes][:speakers_attributes]["0"][:image] = image
      end
      if conf.update_attributes! params[:conference_session]
        flash[:notice] = 'Update successful'
      end
      redirect_to edit_admin_conference_session_path(conf)
    end

  end
end
