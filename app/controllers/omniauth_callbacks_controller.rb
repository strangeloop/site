class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user(provider, attendee_finder)
    omniauth = request.env["omniauth.auth"]
    service = Service.send("#{provider}_service".to_sym, omniauth)
    existing_user = Service.find_existing_attendee_cred(service.provider, service.uid)

    if existing_user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.to_s.capitalize
      sign_in_and_redirect existing_user.attendee_cred, :event => :authentication
    else
      attendee = attendee_finder.call service
      attendee.activate(service)
      sign_in_and_redirect attendee.attendee_cred, :event => :authentication
    end
  end

  def github
    authenticate_user(:github, lambda {|service| Attendee.find_by_email(service.uemail)})
  end

  def twitter
    authenticate_user(:twitter, lambda {|service| Attendee.find_by_twitter_id(omniauth["extra"]["user_hash"]["screen_name"])})
  end

  def google
    authenticate_user(:google, lambda {|service| Attendee.find_by_acct_activation_token(params[:token])})
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
