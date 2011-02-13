class SpeakerMailer < ActionMailer::Base

  default :from => "notifications@strangeloop.com"
 
  def talk_submission_email(talk)
    @talk = talk
    mail(:to => @talk.speakers[0].email,
         :subject => "Your talk was successfully submitted")
  end
end
