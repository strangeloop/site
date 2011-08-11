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
    attendee = Attendee.check_token token
    attendee.build_user(:email => attendee.email, :password => SecureRandom.hex(10),
                        :username => attendee.email)
    attendee.user.services << service
    attendee.save!
  end

  def authenticate_new_user (token, service)
    create_user(token, service)
    flash[:myinfo] = 'Your account on thestrangeloop.com has been created via ' + provider.capitalize
    sign_in_and_redirect(:user, user)
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
      raise "unrecognized provider"
    end

    service
  end
    
  def create
    omniauth = request.env['omniauth.auth']

    if omniauth and params[:service]
      
      service_route = params[:service]
      token = omniauth['token'] || ''
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
              raise format("Authentication provider %s not configured for user", si.provider.capitalize)
            end
          else
            raise "User already signed in"
          end  
        else
          flash[:error] =  service_route.capitalize + ' returned invalid data for the user id.'
          raise format("%s returned invalid data for the user id", service_route.capitalize)
        end
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
      redirect_to new_user_session_path
    end
  end
end
