User.all.each do |user|
  if user.plugins.where(:name => 'sponsorships').blank?
    user.plugins.create(:name => 'sponsorships',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

page = Page.create(
  :title => 'Sponsorships',
  :link_url => '/sponsorships',
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => '^/sponsorships(\/|\/.+?|)$'
)
Page.default_parts.each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end
