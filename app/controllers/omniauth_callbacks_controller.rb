class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github_service(omniauth)
    service = Service.new
    service.uemail = omniauth['user_info']['email']
    service.uname = omniauth['user_info']['name']
    service.uname = omniauth['extra']['user_hash']['name']
    service.uid = omniauth['extra']['user_hash']['id']
    service.provider = omniauth['provider']    
  end

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
    existing_user = Service.find_existing_user(omniauth)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else
      service = github_service omniauth
      attendee = Attendee.find_by_email(service.uemail)
      attendee_cred = create_attendee_cred attendee, service
      sign_in_and_redirect attendee_cred, :event => :authentication
    end
  end

  def twitter_service(omniauth)
    service = Service.new
    service.uname = omniauth['user_info']['name']
    service.uid = omniauth['uid']
    service.provider = omniauth['provider']
    service
  end
  
  def twitter
    omniauth = env["omniauth.auth"]
    existing_user = Service.find_existing_user(omniauth)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else
      service = twitter_service omniauth
      attendee = Attendee.find_by_twitter_id( omniauth["extra"]["user_hash"]["screen_name"])
      attendee_cred = create_attendee_cred attendee, service
      sign_in_and_redirect attendee_cred, :event => :authentication
    end
  end

  def passthru
    debugger
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
