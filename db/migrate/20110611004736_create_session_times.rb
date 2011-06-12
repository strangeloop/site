class CreateSessionTimes < ActiveRecord::Migration
  def self.up
    create_table :session_times do |ts|
      ts.datetime :start_time
      ts.integer :duration_hours
      ts.integer :duration_minutes

      ts.timestamps
    end
  end

  def self.down
    drop_table :session_times
  end
end

