#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-

require_relative '../config/environment'
require 'rspec/rails'
require 'rspec/autorun'

require 'rbconfig'
require 'factory_girl'
require 'factory_girl_rails'
require 'warden'
require 'devise/test_helpers'
require_relative 'controller_macros'
require_relative 'custom_matchers'
require_relative '../vendor/engines/proposals/spec/factories'

def setup_environment
  # This file is copied to ~/spec when you run 'rails generate rspec'
  # from the project root directory.
  require 'shoulda/integrations/rspec2'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.fixture_path = ::Rails.root.join('spec', 'fixtures').to_s

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, comment the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false

    config.include Devise::TestHelpers, :type => :controller
    #ControllerMacros adds login for different roles (defined in Proposal engine)
    config.extend ControllerMacros, :type => :controller
    config.include Devise::TestHelpers, :type => :controller
  end
end

setup_environment

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
 fake.string
end


