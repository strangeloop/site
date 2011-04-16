require 'dragonfly'

#app = Dragonfly[:strangeloop]
#app.configure_with(:imagemagick)
#app.configure_with(:rails)

#app.define_macro(ActiveRecord::Base, :db_image_accessor)
#app.datastore = RelationalDragonflyStore.new


Rails.configuration.after_initialize do
  app = Dragonfly[:images]
  app.configure_with(:rails) do |c|
    c.datastore = RelationalDragonflyStore.new
    #c.datastore.root_path = Rails.root.join('public', 'system', 'images').to_s
    c.url_path_prefix = '/system/images'
    c.secret = RefinerySetting.find_or_set(:dragonfly_secret,
                                          Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
  end
end


