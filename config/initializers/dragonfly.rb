require 'dragonfly'

Rails.configuration.after_initialize do
  app = Dragonfly[:images]
  app.configure_with(:rails) do |c|
    c.datastore = RelationalDragonflyStore.new
    c.url_path_prefix = '/system/images'
    c.secret = RefinerySetting.find_or_set(:dragonfly_secret,
                                          Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
  end
end


