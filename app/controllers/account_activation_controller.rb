class AccountActivationController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :show]
  def new
    attendee = Attendee.check_token(params[:token]) if params[:token]
    debugger
    if attendee
      @attendee = attendee
    else
      nil
    end
  end

  def show
    render "index"
  end
end
