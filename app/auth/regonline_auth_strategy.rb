require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    # Default strategy for signing in a user, based on his email and password in the database.
    class RegOnlineAuthenticatable < Authenticatable
      def authenticate!
        login = params[:user][:login]
        password = params[:user][:password]
        u = valid_password? && User.authenticate_user(login, password, "1066825")
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
