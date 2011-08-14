class AccountActivationController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :show]

  expose(:attendee) { Attendee.check_token(params[:token]) if params[:token] }

  def show
    render "index"
  end
end
