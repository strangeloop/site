class TalksController < ApplicationController

  def new
    @speaker_array = Array.new
    @speaker_array[0] = Speaker.new
    @talk = Talk.new
    @talk.speakers = @speaker_array
  end
  
  def create
    @talk = Talk.new params[:talk]
    @talk.save
    Proposal.create :status => 'submitted', :talk => @talk
    SpeakerMailer.talk_submission_email @talk
  end
end
