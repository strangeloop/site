class AccountActivationController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :show]

  expose(:attendee) {
    begin
      Attendee.check_token(params[:token]) if params[:token]
    rescue ArgumentError
    end
  }

  def new
  end

  def show
    render "index"
  end
end
