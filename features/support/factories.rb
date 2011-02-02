Factory.define :user do |u|
  u.sequence(:username) { |n| "person#{n}" }
  u.sequence(:email) { |n| "person#{n}@cucumber.com" }
  u.password  "greenandjuicy"
  u.password_confirmation "greenandjuicy"
end

Factory.define :refinery_user, :parent => :user do |u|
  u.roles { [ Role[:refinery] ] }

  u.after_create do |user|
    Refinery::Plugins.registered.each_with_index do |plugin, index|
      user.plugins.create(:name => plugin.name, :position => index)
    end
  end
end

Factory.define :reviewer, :parent => :refinery_user do |u|
  u.after_create do |user|
    user.roles << Role[:reviewer]
  end
end

Factory.define :speaker do |s|
  s.first_name 'Earl'
  s.last_name 'Grey'
  s.email 'earl@grey.com'
  s.bio 'Hot tea afficionado'
  s.phone '314-444-1234'
  s.state 'MO'
  s.country 'US'
end

Factory.define :talk_type do |type|
  type.name 'tutorial'
  type.description 'Session meant to teach a specific lesson'
end

Factory.define :talk do |t|
  t.title 'Sample Talk'
  t.abstract 'A talk about samples'
  t.talk_type { Factory(:talk_type) }
  t.speakers { [Factory(:speaker)] }
end

