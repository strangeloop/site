class AttendeeMailer < ActionMailer::Base

  default :from => "notifications@thestrangeloop.com"

  def attendee_activation_email(attendee)
    @attendee = attendee
    mail(:to => attendee.email,
         :subject => subject)
  end
end
