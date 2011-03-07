User.find(:all).each do |user|
  if user.plugins.find_by_name('proposals').nil?
    user.plugins.create(:name => 'proposals',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

