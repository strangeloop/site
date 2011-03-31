source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'formtastic', '~> 1.1.0'
gem 'carmen', '0.2.4'
gem 'ajaxful_rating', '~> 3.0.0.beta3'

gem 'acts-as-taggable-on'

gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '0.8.2'
gem 'uuidtools', '~> 2.1.2'

gem 'acts_as_commentable', '3.0.1'

group :development, :test do
  gem 'sqlite3-ruby', '~> 1.3.2', :require => 'sqlite3'
  gem 'awesome_print', '~> 0.3.2'
  gem 'ruby-debug', '~> 0.10.4'
  #gem 'ruby-debug19', '~> 0.11.6'
end

group :production do
  #gem 'pg', '0.9.0'
  #gem 'unicorn' 
end

group :test do
  gem 'shoulda', '~> 2.11.3'
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'rails3-generators', '~> 0.17.2'
  #gem 'capybara-envjs'
end



# REFINERY CMS ================================================================

# Specify the Refinery CMS core:
gem 'refinerycms',              '= 0.9.9'

group :development, :test do
  # RSpec
  gem 'rspec-rails', '~> 2.5.0'
  # Cucumber
  gem 'capybara', '~> 0.4.1'
  gem 'database_cleaner', '~> 0.6.0'
  gem 'cucumber-rails', '~> 0.4.0.beta.1'
  gem 'launchy', '~> 0.3.7'
  gem 'gherkin'
  gem 'spork', '>= 0.9.0.rc4' unless Bundler::WINDOWS
  gem 'rack-test',              '~> 0.5.6'
  gem 'json_pure', '~> 1.5.1'
  # Factory Girl
  #gem 'factory_girl'
  gem "#{'j' if RUBY_PLATFORM == 'java'}ruby-prof" unless defined?(RUBY_ENGINE) and RUBY_ENGINE == 'rbx'
  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-notification'
end

# END REFINERY CMS ============================================================

# USER DEFINED


# Specify additional Refinery CMS Engines here (all optional):
gem 'refinerycms-generators',   '~> 0.9'
gem 'refinerycms-inquiries',    '~> 0.9.9.9'
gem 'refinerycms-news',         '~> 1.0'
# gem 'refinerycms-portfolio',    '~> 0.9.9'
# gem 'refinerycms-theming',      '~> 0.9.9'
# gem 'refinerycms-search',       '~> 0.9.8'
# gem 'refinerycms-blog',         '~> 1.1'

# Add i18n support (optional, you can remove this if you really want to).
gem 'refinerycms-i18n',         '~> 0.9'


# END USER DEFINED

gem 'refinerycms-proposals', '0.1', :path => 'vendor/engines'

gem 'refinerycms-conference_sessions', '1.0', :path => 'vendor/engines'