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
