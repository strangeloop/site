class TalksController < ApplicationController
  expose(:talk) { build_talk(params) }
  expose(:speaker) { talk.speakers.first }

  def new
  end
  
  def create
    if talk.save
      Proposal.create :status => 'submitted', :talk => talk
      SpeakerMailer.talk_submission_email(talk).deliver
    else
      render :new
    end
  end

  private
  def build_talk(params)
    return Talk.new(:speakers => [Speaker.new]) if params[:talk].nil?
    image_param = params[:talk][:speakers_attributes]["0"].delete(:image)
    image = Image.new(image_param) if image_param
    Talk.new(params[:talk]).tap{|t| t.speakers.first.image = image if image}
  end
end
