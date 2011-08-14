class AccountActivationController < ApplicationController

  def new
    attendee = Attendee.check_token(params[:token]) if params[:token]
    debugger
    if attendee
      @attendee = attendee
    else
      nil
    end
  end
end
