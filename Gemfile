source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'formtastic', '~> 1.1.0'

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'awesome_print'
  gem 'ruby-debug'
end

group :test do
  gem 'ZenTest'
  gem 'rspec'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'rails3-generators'
  #gem 'capybara-envjs'
end



# REFINERY CMS ================================================================

java = (RUBY_PLATFORM == 'java')

# Specify the Refinery CMS core:
gem 'refinerycms',              :git => 'git://github.com/resolve/refinerycms.git', :branch => 'master'

gem 'friendly_id',              :git => 'git://github.com/parndt/friendly_id', :branch => 'globalize3'
gem 'globalize3',               :git => 'git://github.com/refinerycms/globalize3'

# Specify additional Refinery CMS Engines here (all optional):
gem 'refinerycms-generators',   '~> 0.9.9', :git => 'git://github.com/resolve/refinerycms-generators'
# gem 'refinerycms-inquiries',    '~> 0.9.9.9'
# gem 'refinerycms-news',         '~> 1.0'
# gem 'refinerycms-portfolio',    '~> 0.9.9'
# gem 'refinerycms-theming',      '~> 0.9.9'
# gem 'refinerycms-search',       '~> 0.9.8'
# gem 'refinerycms-blog',         '~> 1.1'

# Add i18n support (optional, you can remove this if you really want to).
gem 'routing-filter',           :git => 'git://github.com/refinerycms/routing-filter'
gem 'refinerycms-i18n',         :git => 'git://github.com/resolve/refinerycms-i18n'

gem 'jruby-openssl' if java

group :development, :test do
  # RSpec
  gem 'rspec-rails',            '= 2.3'
  # Cucumber
  gem 'capybara',               :git => 'git://github.com/parndt/capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'launchy'
  gem 'gherkin'
  gem 'spork' unless Bundler::WINDOWS
  gem 'rack-test',              '~> 0.5.6'
  # FIXME: Update json_pure to 1.4.7 when it is released
  gem 'json_pure', "1.4.6a", :git => "git://github.com/flori/json", :ref => "2c0f8d"
  # Factory Girl
  #gem 'factory_girl'
  gem "#{'j' if java}ruby-prof" unless defined?(RUBY_ENGINE) and RUBY_ENGINE == 'rbx'
  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-notification'
  # FIXME: Replace when new babosa gem is released
  gem 'babosa', '0.2.0',        :git => 'git://github.com/stevenheidel/babosa' if java
end

# END REFINERY CMS ============================================================
