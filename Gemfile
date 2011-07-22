source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'formtastic', '~> 1.2.3'
gem 'carmen', '0.2.4'
gem 'ajaxful_rating', '~> 3.0.0.beta3'

gem 'acts-as-taggable-on'

gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '0.8.2'
gem 'uuidtools', '~> 2.1.2'

gem 'acts_as_commentable', '3.0.1'
gem 'fastercsv', '1.5.4'
gem 'gravtastic'

gem 'mmcopyrights'
gem 'regonline-ruby', :git => 'git://github.com/strangeloop/regonline-ruby'
gem 'friendly_id_globalize3', '~> 3.2.1'
gem 'decent_exposure', '~> 1.0'
gem 'RedCloth', '~> 4.2'
gem 'jammit', '~> 0.6'
gem 'client_side_validations', '~> 3.0.4'

gem 'savon', '0.9.1'

gem 'require_relative', '1.0.1'

group :development, :test do
  gem 'sqlite3-ruby', '~> 1.3.2', :require => 'sqlite3'
  gem 'awesome_print', '~> 0.4.0'
  gem 'ruby-debug', '~> 0.10.4'
  #gem 'ruby-debug19', '~> 0.11.6'
end

group :production do
  gem 'mysql2', '0.2.7'
  gem 'unicorn', '3.6.0'
  gem 'rack-ssl', :require => 'rack/ssl'
end

group :test do
  gem 'shoulda', '~> 2.11.3'
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'rails3-generators', '~> 0.17.2'
  gem 'jasmine'
  #gem 'capybara-envjs'
end

# REFINERY CMS ================================================================

# Specify the Refinery CMS core:
#gem 'refinerycms',              '= 0.9.9.15'

#Branch off of 0.9.9.15 with fix for _path instead of _url for SSL support
#And with fix for erroneous call to '.url' method on object that doesn't respond to that
#And with fix that doesn't assume cache strategy is file/directory backed
#And with Google Analytics _trackPageLoadTime
#And switching defaults that would otherwise say 'Company Name' to 'Strange Loop'
gem 'refinerycms', :git => "git://github.com/strangeloop/refinerycms.git", :branch => 'path_not_url_ssl_fix', :ref => '6ba952141436b69b7feab69498709090815a7271'

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
gem 'refinerycms-news',         '1.0.1' #Use this version specifically
# gem 'refinerycms-search',       '~> 0.9.8'

# END USER DEFINED

gem 'refinerycms-proposals', '1.0', :path => 'vendor/engines'

gem 'refinerycms-conference_sessions', '1.0', :path => 'vendor/engines'

gem 'refinerycms-sponsorships', '1.0', :path => 'vendor/engines'
