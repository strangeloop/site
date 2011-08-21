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

  def create_user (token, service)

    attendee = Attendee.where("acct_activation_token = ?", CGI.unescape(token)).first

    if attendee
      attendee.build_user(:email => attendee.email,
                          :password => SecureRandom.hex(10),
                          :username => attendee.email) unless attendee.user

      attendee.acct_activation_token = nil
      attendee.token_created_at = nil
      attendee.user.services << service
      attendee.save!
      attendee
    else
      logger.warn "Can't find attendee with token #{token}"
      flash[:error] = "No registered attendee found for token"
    end
  end

  def authenticate_new_user (token, service)
    attendee = create_user(token, service)
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

  def create

    omniauth = request.env['omniauth.auth']
    if omniauth and params[:service]

      service_route = params[:service]
      token = params[:token] || ''
      si = service_info(service_route, omniauth)

      if token != ''
        authenticate_new_user(token, si)
      else
        # continue only if provider and uid exist
        if si.uid != '' and si.provider != ''
          # nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
          if !user_signed_in?
            # check if user has already signed in using this service provider and continue with sign in process if yes
            auth = Service.find_by_provider_and_uid(si.provider, si.uid)
            if auth
              flash[:notice] = 'Signed in successfully via ' + si.provider.capitalize + '.'
              sign_in_and_redirect(:user, auth.user)
            else
              logger.warn "Authentication provider #{si.provider.capitalize} not configured for user"
              flash[:error] = "Authentication provider #{si.provider.capitalize} not configured for user"
            end
          else
            logger.warn  "User already signed in"
            flash[:error] = "User already signed in"
          end
        else
          logger.warn "#{service_route.capitalize} returned invalid data for the user id"
          flash[:error] = "Error authenticating user"
        end
      end
    else
      logger.warn "No omniauth hash or service found.  Omniauth is #{omniauth} and service is #{params[:service]}"
      flash[:error] = 'Error authenticating user'
      redirect_to new_user_session_path
    end
  end
end
