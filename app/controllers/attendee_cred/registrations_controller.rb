class AttendeeCred
  class RegistrationsController < Devise::RegistrationsController

    def new
      render 'devise/registrations/new'
    end

    def after_sign_up_path_for(resource)
      attendee_path(resource.attendee)
    end
    
    def create

      build_resource
      attendee = Attendee.check_token(CGI.unescape(params[:token][:text]))
      attendee.register resource
      resource.attendee= attendee

      if attendee && resource.save

        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up
          sign_in_and_redirect(resource_name, resource)
        else
          set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
          expire_session_data_after_sign_in!
          redirect_to after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords(resource)
        flash[:error] = "Failed to create password, please try again"
        redirect_to activation_path(:token => params[:token])
      end

    end

    def update
      super
    end
  end
end
