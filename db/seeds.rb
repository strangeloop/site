# Refinery seeds
%w[pages pages_for_inquiries refinerycms_news proposals refinery_settings].each do |seed_name|
  Dir[Rails.root.join('db', 'seeds', "#{seed_name}.rb").to_s].each do |file|
    puts "Loading db/seeds/#{file.split(File::SEPARATOR).last}"
    load(file)
  end
end
