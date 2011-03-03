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
  u.after_create do |user|
    user.plugins.create(:name => "refinery_dashboard", :position => 0)
    user.plugins.create(:name => "proposals", :position => 1)
    [:refinery, :reviewer].each{|role| user.roles << Role[role] }
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
  s.image      'foo'
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

