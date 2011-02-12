Factory.define :proposal do |p|
  p.status 'submitted'
  p.talk   { Factory(:talk) }
end
