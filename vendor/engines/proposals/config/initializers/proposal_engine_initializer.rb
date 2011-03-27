require 'proposal_status_updater'

ActiveRecord::Base.observers = :comment_observer, :rate_observer

