# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'mmcopyrights'

Conf::Application.load_tasks

task :copyrights do
  ['app', 'autotest', 'config', 'features', 'lib', 'spec', 'vendor/engines'].each do |dir|
    MM::Copyrights.process(dir, 'rb', '#-', IO.read('license.md'))
  end
end

