class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

  def index
    # get all authentication services assigned to the current user
    @services = current_user.services.all
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    @service.destroy
    
    redirect_to services_path
  end

  def create_user (attendee, service)
      attendee.build_user(:email => attendee.email,
                          :password => SecureRandom.hex(10),
                          :username => attendee.email) unless attendee.user

      attendee.acct_activation_token = nil
      attendee.token_created_at = nil
      attendee.user.services << service
      attendee.save!
      attendee
  end

  def authenticate_new_user (attendee, service)
    attendee = create_user(attendee, service)
    flash[:attendee] = 'Your account on thestrangeloop.com has been created via ' + service.provider.capitalize
    sign_in_and_redirect(:user, attendee.user)
  end

  def service_info(service_route, omniauth)
    service = Service.new

    if service_route == 'facebook'
      service.uemail = omniauth['extra']['user_hash']['email'] || ''
      service.uname = omniauth['extra']['user_hash']['name'] || ''
      service.uid = omniauth['extra']['user_hash']['id'] || ''
      service.provider = omniauth['provider'] || ''
    elsif service_route == 'github'
      service.uemail = omniauth['user_info']['email'] || ''
      service.uname = omniauth['user_info']['name'] || ''
      service.uname = omniauth['extra']['user_hash']['name'] || ''
      service.uid = omniauth['extra']['user_hash']['id'] || ''
      service.provider = omniauth['provider'] || ''
    elsif service_route == 'twitter'
      service.uemail = ''    # Twitter API never returns the email  address
      service.uname = omniauth['user_info']['name'] || ''
      service.uid = omniauth['uid'] || ''
      service.provider = omniauth['provider'] || ''
    elsif service_route == 'google'
      service.uemail = omniauth['user_info']['email'] || ''
      service.uname = omniauth['user_info']['name'] || ''
      service.uid = omniauth['uid'] || ''
      service.provider = omniauth['provider'] || ''
    else
      logger.warn "No provider found for route #{service_route}.  Hash returned: omniauth"
      flash[:error] = "Error authenticating user"
    end

    service
  end

  def attendee_from_auth(service, token, twitter_id)
    provider = service.provider.capitalize
    if provider == 'Google'
     Attendee.where("acct_activation_token = ?", CGI.unescape(token)).first      
    elsif provider == 'Twitter'
      Attendee.where("twitter_id = ? or twitter_id = ?", twitter_id, "@#{twitter_id}").first      
    elsif provider == 'Github'
      Attendee.where("email = ?", service.uemail).first
    else
      nil
    end
  end

  def sign_in_user(service, token, omniauth)
     # check if user has already signed in using this service provider and continue with sign in process if yes
    existing_service = Service.find_by_provider_and_uid(service.provider, service.uid)          
    if existing_service
      flash[:notice] = 'Signed in successfully via ' + service.provider.capitalize + '.'
      sign_in_and_redirect(:user, existing_service.user)
    else
      twitter_id = omniauth["extra"] && omniauth["extra"]["user_hash"] && omniauth["extra"]["user_hash"]["screen_name"]
      attendee = attendee_from_auth service, token, twitter_id
      
      if attendee
        authenticate_new_user(attendee, service)
      else
        logger.warn "Can't find attendee with token #{token}, email #{service.uemail} and twitter_id: #{twitter_id} for provider #{service.provider}"
        flash[:error] = "No registered attendee found for token"
      end
    end
  end
  
  def create
    omniauth = request.env['omniauth.auth']
    if omniauth and params[:service]
      service_route = params[:service]
      token = params[:token] || ''
      si = service_info(service_route, omniauth)

      if si.uid != '' && si.provider != ''
        # nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
        if !user_signed_in?
          sign_in_user si, token, omniauth
        else
          logger.warn  "User already signed in"
          flash[:error] = "User already signed in"
        end  
      else
        logger.warn "#{service_route.capitalize} returned invalid data for the user id (no uid or provider)"
        flash[:error] = "Error authenticating user"
      end
    else
      logger.warn "No omniauth hash or service found.  Omniauth is #{omniauth} and service is #{params[:service]}"
      flash[:error] = 'Error authenticating user'
      redirect_to new_user_session_path
    end
  end
end
