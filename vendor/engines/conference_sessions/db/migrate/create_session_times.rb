class CreateSessionTimes < ActiveRecord::Migration
  def self.up
    create_table :session_times do |ts|
      ts.datetime :start_time
      ts.datetime :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :session_times
  end
end

