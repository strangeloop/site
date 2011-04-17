require File.expand_path(File.dirname(__FILE__) + '/../../vendor/engines/proposals/spec/factories')
#require File.expand_path(File.dirname(__FILE__) + '/../../vendor/engines/conference_sessions/spec/factories')

require 'factory_girl/step_definitions'

After do |scenario|  
  if scenario.status == :failed
    save_and_open_page
  end  
end

