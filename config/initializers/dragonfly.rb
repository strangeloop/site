require 'dragonfly/rails/images'

app = Dragonfly[:strangeloop]

app.configure do |c|
  c.datastore = RelationalDragonflyStore.new
end
