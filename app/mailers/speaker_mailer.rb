class SpeakerMailer < ActionMailer::Base

  default :from => "notifications@strangeloop.com"


  def find_reviewer_admins()
    Role[:submission_admin].users.collect{|u| u.email}
  end
  
  def talk_submission_email(talk)
    @talk = talk
    mail(:to => @talk.speakers[0].email,
         :cc => find_reviewer_admins,
         :subject => "Your talk was successfully submitted")
  end
end
