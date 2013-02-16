require_relative '../models/conference_session'
require_relative '../models/room'
require_relative '../models/session_time'
require_relative '../models/track'

class ClearScheduleCache < ActionController::Caching::Sweeper
  observe ConferenceSession, Room, SessionTime, Track

  def after_create(model)
    delete_schedule_cache
  end

  def after_update(model)
    delete_schedule_cache
  end

  def after_destroy(model)
    delete_schedule_cache
  end

  private
  def delete_schedule_cache
    expire_fragment 'schedule'
    expire_fragment 'auth-schedule'
  end
end
