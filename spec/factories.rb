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

Factory.define :speaker do |s|
  s.first_name 'Earl'
  s.last_name  'Grey'
  s.email      'earl@grey.com'
  s.bio        'Hot tea afficionado'
  s.phone      '314-444-1234'
  s.state      'MO'
  s.country    'US'
  s.db_image   'foo'
end

Factory.define :talk do |t|
  t.title          'Sample Talk'
  t.abstract       'A talk about samples'
  t.talk_type      'Intro'
  t.track          'JVM'
  t.video_approval 'Yes'
  t.talk_length    '5 Minutes'
  t.speakers       { [Factory(:speaker)] }
end

