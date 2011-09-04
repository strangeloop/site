class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user(provider, attendee_finder)
    omniauth = request.env["omniauth.auth"]
    service = Service.send("#{provider}_service".to_sym, omniauth)
    existing_user = Service.find_existing_attendee_cred(service.provider, service.uid)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :provider => provider.to_s.capitalize
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else
      attendee = attendee_finder.call service

      if attendee
        attendee.activate(service)
        flash[:notice] = I18n.t "devise.omniauth_callbacks.register_success",
        :email => attendee.email,:provider=> provider.to_s.capitalize
        sign_in_and_redirect attendee.attendee_cred, :event => :authentication
      else
        redirect_to new_attendee_session_path
      end
    end
  end

  def error_on_nil(attendee, error_s)
    flash[:error] = I18n.t(error_s) unless attendee
    attendee
  end

  def github_attendee(service)
    error_on_nil(Attendee.find_by_email(service.uemail), "devise.omniauth_callbacks.github_reg_fail")
  end

  def github
    authenticate_user(:github, method(:github_attendee))
  end

  def twitter_attendee(service)
    error_on_nil(Attendee.find_by_twitter_id(service.twitter_id),"devise.omniauth_callbacks.twitter_reg_fail")
  end
  
  def twitter
    authenticate_user(:twitter, method(:twitter_attendee))
  end

  def google
    authenticate_user(:google, lambda {|service| Attendee.find_by_acct_activation_token(params[:token])})
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
