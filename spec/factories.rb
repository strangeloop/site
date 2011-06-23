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



Factory.define :user do |u|
  u.sequence(:username) { |n| "person#{n}" }
  u.sequence(:email) { |n| "person#{n}@cucumber.com" }
  u.password  "greenandjuicy"
  u.password_confirmation "greenandjuicy"
end

Factory.define :admin, :parent => :user do |u|
  u.roles { [ Role[:refinery] ] }

  u.after_create do |user|
    Refinery::Plugins.registered.each_with_index do |plugin, index|
      user.plugins.create(:name => plugin.name, :position => index)
    end
  end
end

Factory.define :reviewer, :parent => :user do |u|
  u.username "reviewer"
  u.after_create do |user|
    user.plugins.create(:name => "refinery_dashboard", :position => 0)
    user.plugins.create(:name => "proposals", :position => 1)
    [:refinery, :reviewer].each{|role| user.roles << Role[role] }
  end
end

Factory.define :submission_admin1, :parent => :user do |u|
  u.username "submissionadm1"
  u.email "subadmin1@strangloop.com"
  u.roles {[Role["Submission Admin"]]}
end

Factory.define :submission_admin2, :parent => :user do |u|
  u.username "submissionadm2"
  u.email "subadmin2@strangloop.com"
  u.roles {[Role["Submission Admin"]]}
end

Factory.define :alternate_reviewer, :parent => :reviewer do |u|
  u.username 'alternate_reviewer'
end

Factory.define :alternate_reviewer2, :parent => :reviewer do |u|
  u.username 'alternate_reviewer2'
end

Factory.define :alternate_reviewer3, :parent => :reviewer do |u|
  u.username 'alternate_reviewer3'
end

Factory.define :organizer, :parent => :reviewer do |u|
  u.username 'organizer'
  u.after_create do |user|
    user.plugins.create(:name => "conference_sessions", :position => 1)
    user.roles << Role[:organizer]
  end
end

Factory.define :image do |i|
  i.image File.new(File.expand_path('../uploads/image.jpeg', __FILE__))
end

Factory.define :speaker do |s|
  s.first_name  'Earl'
  s.last_name   'Grey'
  s.email       'earl@grey.com'
  s.twitter_id  'earlofgrey'
  s.company_url 'http://teabaggery.com'
  s.bio         'Hot tea afficionado'
  s.phone       '314-444-1234'
  s.state       'MO'
  s.country     'US'
  #s.image       { Factory(:image) }
end

Factory.define :talk do |t|
  t.title          'Sample Talk'
  t.abstract       'A talk about samples'
  t.talk_type      'Intro'
  t.video_approval 'Yes'
  t.speakers       { [Factory(:speaker)] }
end

Factory.define :keynote_speaker, :parent => :speaker do |ks|
  ks.first_name 'Hank'
  ks.last_name 'Moody'
  ks.twitter_id 'hankypanky'
  ks.company 'Unemployable'
  ks.company_url 'http://unemployable.com'
  ks.bio 'Single father, living a player lifestyle in California.'
end

Factory.define :workshop_speaker, :parent => :speaker do |ws|
  ws.first_name 'Charlie'
  ws.last_name 'Sheen'
  ws.twitter_id 'adonisdna'
  ws.company_url 'http://winning.com'
end

Factory.define :keynote_talk, :parent => :talk do |kt|
  kt.title 'God Hates Us All'
  kt.abstract 'A writer tries to juggle his career, his relationship with his daughter and his ex-girlfriend, as well as his appetite for beautiful women.'
  kt.speakers { [Factory(:keynote_speaker)] }
end

Factory.define :workshop_talk, :parent => :talk do |wt|
  wt.title 'Winning with Tiger Blood'
  wt.speakers { [Factory(:workshop_speaker)] }
end

Factory.define :conference_session do |cs|
end

Factory.define :keynote_session, :parent => :conference_session do |ks|
  ks.format 'keynote'
  ks.talk { Factory(:keynote_talk) }
end

Factory.define :workshop_session, :parent => :conference_session do |ws|
  ws.format 'workshop'
  ws.talk { Factory(:workshop_talk) }
end

Factory.define :talk_session, :parent => :conference_session do |ws|
  ws.format 'talk'
  ws.talk { Factory(:talk) }
end

Factory.define :last_years_talk_session, :parent => :talk_session do |lyts|
  lyts.conf_year Time.now.year - 1
end

Factory.define :talk_session_2009, :parent => :talk_session do |lyts|
  lyts.conf_year 2009
end

Factory.define :sponsorship_level do |sl|
  sl.name 'Platinum'
  sl.year Time.now.year
  sl.position 1
end

Factory.define :platinum_last_year, :parent => :sponsorship_level do |sl|
  sl.year Time.now.year - 1
end

Factory.define :silver, :parent => :sponsorship_level do |sl|
  sl.name 'Silver'
  sl.position 2
end

Factory.define :bronze, :parent => :sponsorship_level do |sl|
  sl.name 'Bronze'
  sl.position 3
end

Factory.define :sponsor do |s|
  s.name 'foogle'
  s.description 'A fake company'
  s.url 'http://foogle.com'
end

Factory.define :contact do |c|
  c.name 'Me You'
  c.email 'me@you.com'
  c.phone '314-555-1212'
end

Factory.define :sponsorship do |s|
  s.sponsor { Factory(:sponsor) }
  s.contact { Factory(:contact) }
  s.sponsorship_level { Factory(:sponsorship_level) }
  s.visible true
  s.year 2011
  s.position 1
end

Factory.define :platinum_sponsorship, :parent => :sponsorship do |ps|
end

Factory.define :platinum_sponsorship_last_year, :parent => :sponsorship do |ps|
  ps.year Time.now.year - 1
  ps.sponsorship_level { Factory(:platinum_last_year) }
end

Factory.define :silver_sponsorship, :parent => :sponsorship do |ss|
  ss.sponsorship_level { Factory(:silver) }
end

Factory.define :bronze_sponsorship, :parent => :sponsorship do |bs|
  bs.sponsorship_level { Factory(:bronze) }
end

Factory.define :room do |rm|
  rm.name 'Room 1'
  rm.capacity 200
  rm.position 1
  rm.conf_year Time.now.year
end

Factory.define :big_room, :parent => :room do |br|
  br.capacity 1000
  br.name 'Big Room'
  br.position 0
end

Factory.define :small_room, :parent => :room do |sr|
  sr.capacity 100
  sr.name 'Small Room'
  sr.position 2
end

Factory.define :room_from_2009, :parent => :room do |lyr|
  lyr.conf_year 2009
end

Factory.define :session_time do |st|
  st.start_time DateTime.parse('Thursday, July 1, 2010 12:30 PM')
  st.duration_hours 1
  st.duration_minutes 0
end

Factory.define :session_time_from_this_year, :parent => :session_time do |st|
  st.start_time DateTime.parse 'Tuesday, 12:30 PM'
end

Factory.define :morning_session_time, :parent => :session_time do |ms|
  ms.start_time DateTime.parse('Thursday, July 1, 2010 09:00 AM')
end

Factory.define :evening_session_time, :parent => :session_time do |es|
  es.start_time DateTime.parse('Thursday, July 1, 2010 05:00 PM')
end

Factory.define :session_time_2009, :parent => :session_time do |lyst|
  lyst.start_time DateTime.parse("July 6, 2009, 12:30 PM")
end

Factory.define :track do |t|
  t.name 'Ruby'
  t.color 'ff0000'
end
