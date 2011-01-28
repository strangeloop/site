source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'formtastic', '~> 1.1.0'

gem 'carmen', '0.2.4'

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'awesome_print'
  #gem 'ruby-debug'
  gem 'ruby-debug19'
end

group :production do
  gem 'pg', '0.9.0'
  gem 'unicorn'
end

group :test do
  #gem 'ZenTest'
  #gem 'rspec'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'rails3-generators'
  #gem 'capybara-envjs'
end



# REFINERY CMS ================================================================

# Specify the Refinery CMS core:
gem 'refinerycms',              '= 0.9.9'

group :development, :test do
  # RSpec
  gem 'rspec-rails',            '= 2.3'
  # Cucumber
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'launchy'
  gem 'gherkin'
  gem 'spork' unless Bundler::WINDOWS
  gem 'rack-test',              '~> 0.5.6'
  gem 'json_pure'
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
# gem 'refinerycms-inquiries',    '~> 0.9.9.9'
# gem 'refinerycms-news',         '~> 1.0'
# gem 'refinerycms-portfolio',    '~> 0.9.9'
# gem 'refinerycms-theming',      '~> 0.9.9'
# gem 'refinerycms-search',       '~> 0.9.8'
# gem 'refinerycms-blog',         '~> 1.1'

# Add i18n support (optional, you can remove this if you really want to).
gem 'refinerycms-i18n',         '~> 0.9'


# END USER DEFINED
