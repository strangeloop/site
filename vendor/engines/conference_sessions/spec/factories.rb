Factory.define :keynote_speaker, :parent => :speaker do |ks|
  ks.first_name 'Hank'
  ks.last_name 'Moody'
  ks.twitter_id 'hankypanky'
  ks.company 'Unemployable'
  ks.company_url 'http://unemployable.com'
  ks.bio 'Single father, living a player lifestyle in California.'
end

Factory.define :keynote_talk, :parent => :talk do |kt|
  kt.title 'God Hates Us All'
  kt.speakers { [Factory(:keynote_speaker)] }
end

Factory.define :conference_session do |cs|
  cs.title 'God Hates Us All' #This title field in conference_session is a refinery wart
  cs.talk { Factory(:keynote_talk) }
end

Factory.define :keynote_session, :parent => :conference_session do
end

