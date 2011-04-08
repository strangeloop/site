User.find(:all).each do |user|
  user.plugins.create(:name => "refinerycms_news",
                      :position => (user.plugins.maximum(:position) || -1) +1)
end

