class TalksController < ApplicationController
  expose(:talk) { Talk.new( params[:talk] || {:speakers => [Speaker.new]}) }
  expose(:speaker) { talk.speakers.first }

  def new
  end
  
  def create
    if talk.save
      Proposal.create :status => 'submitted', :talk => talk
      SpeakerMailer.talk_submission_email talk
    else
      render :new
    end
  end
end
