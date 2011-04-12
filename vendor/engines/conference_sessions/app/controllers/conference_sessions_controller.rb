class ConferenceSessionsController < ApplicationController

  before_filter :find_all_conference_sessions

  def index
    @sessions_by_format = Hash.new{|hash, key| hash[key] = []}
    @conference_sessions.each{|conf_session| @sessions_by_format[conf_session.format] << conf_session}
  end

  def show
    @conference_session = ConferenceSession.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @conference_session in the line below:
    present(@page)
  end

protected

  def find_all_conference_sessions
    @conference_sessions = ConferenceSession.find(:all, :order => "position ASC")
  end

end
