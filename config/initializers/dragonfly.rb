require 'dragonfly'

app = Dragonfly[:strangeloop]
app.configure_with(:imagemagick)
app.configure_with(:rails)

app.define_macro(ActiveRecord::Base, :image_accessor)
app.datastore = RelationalDragonflyStore.new





