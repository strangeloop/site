class SpeakerMailer < ActionMailer::Base

  default :from => "notifications@strangeloop.com"


  def find_reviewer_admins()
    Role["Submission Admin"].users.collect{|u| u.email}
  end

  def send_email_with_cc(talk, subject)
    mail(:to => talk.speakers[0].email,
         :cc => find_reviewer_admins,
         :subject => subject)
  end
    
  
  def talk_submission_email(talk)
    @talk = talk
    send_email_with_cc(talk, "Your talk was successfully submitted")
  end

  def talk_accepted_email(talk)
    @talk = talk
    send_email_with_cc(talk, "Strange Loop Talk proposal accepted")
  end

  def talk_rejected_email(talk)
    @talk = talk
    send_email_with_cc(talk, "Strange Loop Talk proposal rejected")
  end
end
