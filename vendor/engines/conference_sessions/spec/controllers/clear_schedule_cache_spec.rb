require 'spec_helper'

describe Admin::ConferenceSessionsController do
  login_organizer

  let (:conf_session_params) do
    {'talk_attributes' => {
      'title' => 'A new title',
      'abstract' => 'foo',
      'talk_type' => 'Intro',
      'video_approval' => 'Yes',
      'speakers_attributes' => {
        '0' => {
          'first_name' => 'Mario',
          'last_name' => 'Aquino',
          'email' => 'me@you.com',
          'bio' => 'I am made of barley'
        }
    }}}
  end

  it "deletes the schedule cache #after_create" do
    delete_schedule_cache_expectations do
      post :create, :conference_session => conf_session_params
    end
  end

  it "deletes the schedule cache #after_update" do
    ks = Factory(:keynote_session)
    delete_schedule_cache_expectations do
      post :update, :id => ks.id, :conference_session => conf_session_params
    end
  end

  def delete_schedule_cache_expectations
    %w(schedule auth-schedule).each do |key|
      ClearScheduleCache.instance.should_receive(:expire_fragment).with(key)
    end
    yield
  end

  it "deletes the schedule cache #after_destroy" do
    ks = Factory(:keynote_session)
    delete_schedule_cache_expectations do
      post :destroy, :id => ks.id
    end
  end
end
