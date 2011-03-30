User.find(:all).each do |user|
  if user.plugins.find_by_name('conference_sessions').nil?
    user.plugins.create(:name => 'conference_sessions',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

