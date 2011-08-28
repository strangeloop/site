class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def create_attendee_cred (attendee, service)
      attendee.build_attendee_cred(:email => attendee.email,
                                   :password => SecureRandom.hex(10)) unless attendee.attendee_cred

      attendee.acct_activation_token = nil
      attendee.token_created_at = nil
      attendee.attendee_cred.services << service
      attendee.save!
      attendee.attendee_cred
  end


  def github
    omniauth = env["omniauth.auth"]
    service = Service.github_service omniauth
    existing_user = Service.find_existing_user(service.provider, service.uid)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else

      attendee = Attendee.find_by_email(service.uemail)
      attendee_cred = create_attendee_cred attendee, service
      sign_in_and_redirect attendee_cred, :event => :authentication
    end
  end

  def twitter
    omniauth = env["omniauth.auth"]
    service = Service.twitter_service omniauth
    existing_user = Service.find_existing_attendee_cred(service.provider, service.uid)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else

      attendee = Attendee.find_by_twitter_id( omniauth["extra"]["user_hash"]["screen_name"])
      attendee_cred = create_attendee_cred attendee, service
      sign_in_and_redirect attendee_cred, :event => :authentication
    end
  end

  def google
    omniauth = env["omniauth.auth"]
    service = Service.google_service omniauth
    existing_user = Service.find_existing_attendee_cred(service.provider, service.uid)
    debugger
    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else

      attendee = Attendee.find_by_acct_activation_token(params[:token])
      attendee_cred = create_attendee_cred attendee, service
      sign_in_and_redirect attendee_cred, :event => :authentication
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
