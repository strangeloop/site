require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class RegOnlineAuthenticatable < Authenticatable
      def authenticate!
        debugger
        login = params[:attendee_cred][:email]
        password = params[:attendee_cred][:password]
        u = valid_password? && AttendeeCred.authenticate_user(login, password, "1066825")
        if validate(u){u.valid_password?(password) }
          u.after_database_authentication
          success!(u)
        elsif
          fail!(:invalid)
        end
      end
    end
  end
end

Warden::Strategies.add(:regonline_authenticatable, Devise::Strategies::RegOnlineAuthenticatable)
