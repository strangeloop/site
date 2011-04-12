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

