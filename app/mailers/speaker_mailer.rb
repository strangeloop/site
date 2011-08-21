#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



class SpeakerMailer < ActionMailer::Base

  default :from => "notifications@thestrangeloop.com"


  def find_reviewer_admins
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

  def talk_accepted_email(talk, session_time)
    @talk = talk
    @session_time = session_time
    send_email_with_cc(talk, "Strange Loop Talk proposal accepted")
  end

  def talk_rejected_email(talk)
    @talk = talk
    send_email_with_cc(talk, "Strange Loop Talk Proposal")
  end
end
