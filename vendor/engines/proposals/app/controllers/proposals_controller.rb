class ProposalsController < ApplicationController
  expose(:talk) { build_talk }
  expose(:speaker) { talk.speakers.first }
  expose(:format) { params[:format] || params[:proposal][:format] }
  expose(:proposal) { Proposal.new :format => format, :talk => talk }
  expose(:talk_types) { Talk.talk_types }
  expose(:tracks) { Track.current_year }
  expose(:video_approvals) { Talk.video_approvals }
  expose(:durations) { Talk.talk_durations }

  def new
    render "new_#{format}"
  end

  def create
    if talk.save
      Proposal.create :status => 'submitted', :talk => talk, :format => format
      email_method = format == 'workshop' ? 'workshop_submission_email' : 'talk_submission_email'
      SpeakerMailer.send(email_method, talk).deliver
      render "create_#{format}"
    else
      render "new_#{format}"
    end
  end

  private
  def build_talk
    return Talk.new(:speakers => [Speaker.new]) if params[:proposal].nil?
    image_param = params[:proposal][:talk_attributes][:speakers_attributes]["0"].delete(:image)
    image = Image.new(image_param) if image_param
    Talk.new(params[:proposal][:talk_attributes]).tap{|t| t.speakers.first.image = image if image}
  end
end
