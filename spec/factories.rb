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
  u.roles {[Role[:submission_admin]]}
end

Factory.define :submission_admin2, :parent => :user do |u|
  u.username "submissionadm2"
  u.email "subadmin2@strangloop.com"
  u.roles {[Role[:submission_admin]]}
end


Factory.define :alternate_reviewer, :parent => :reviewer do |u|
  u.username 'alternate_reviewer'
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


