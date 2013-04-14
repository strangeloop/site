source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'formtastic', '~> 1.2.3'
gem 'carmen', '0.2.4'
gem 'ajaxful_rating', '3.0.0.beta8'

gem 'acts-as-taggable-on', '~> 2.2.2'

gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '~> 0.9.14'
gem 'uuidtools', '~> 2.1.2'

gem 'acts_as_commentable', '3.0.1'
gem 'gravtastic'

gem 'mmcopyrights'
gem 'decent_exposure', '~> 2.1.0'
gem 'RedCloth', '~> 4.2'
gem 'client_side_validations', '~> 3.0.4'
gem 'ri_cal', '~> 0.8.8'

gem 'savon', '0.9.1'
gem 'faraday_middleware','0.6.3'
gem 'nokogiri', '1.5.0'

group :development, :test do
  gem 'mongrel', '~> 1.2.0.pre2'
  gem 'sqlite3'
  gem 'awesome_print', '~> 0.4.0'
  gem 'debugger', '~> 1.3'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.0.0'

group :production do
  gem "mysql2", "~> 0.3.11"
  gem 'unicorn', '3.6.0'
  gem 'rack-ssl', :require => 'rack/ssl'
end

group :test do
  gem 'shoulda', '~> 3.3.2'
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'rails3-generators', '~> 0.17.2'
  gem 'jasmine'
  gem 'rspec-rails', '~> 2.13.0'
  gem 'capybara', '~> 1.1.2'
  gem 'database_cleaner', '~> 0.6.0'
  gem 'cucumber-rails', '~> 1.0.2'
  gem 'launchy', '~> 0.3.7'
  gem 'gherkin'
  gem 'json_pure', '~> 1.5.1'
end

gem 'refinerycms', '~> 2.0.0', :git => 'git://github.com/refinery/refinerycms.git', :branch => '2-0-stable'

# Specify additional Refinery CMS Extensions here (all optional):
gem 'refinerycms-i18n', '~> 2.0.0'

#Branch off of 0.9.9.15 with fix for _path instead of _url for SSL support
#And with fix for erroneous call to '.url' method on object that doesn't respond to that
#And with fix that doesn't assume cache strategy is file/directory backed
#And with Google Analytics _trackPageLoadTime
#And switching defaults that would otherwise say 'Company Name' to 'Strange Loop'
#gem 'refinerycms', :git => "git://github.com/strangeloop/refinerycms.git", :branch => 'path_not_url_ssl_fix', :ref => 'aeaaef2078903cb9ec9f8b80f45aeb335f7acc13'

# Specify additional Refinery CMS Engines here (all optional):
#gem 'refinerycms-news',         '1.0.1' #Use this version specifically
gem 'refinerycms-news',         '~> 2.0.0'
# gem 'refinerycms-search',       '~> 0.9.8'

gem 'refinerycms-proposals', '1.0', :path => 'vendor/engines/proposals'

gem 'refinerycms-conference_sessions', '1.0', :path => 'vendor/engines/conference_sessions'

gem 'refinerycms-sponsorships', '1.0', :path => 'vendor/engines/sponsorships'
