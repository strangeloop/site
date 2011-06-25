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
    Rails.cache.delete 'schedule'
  end
end
