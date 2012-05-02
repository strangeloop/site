class AddIndexToRegIdOnAttendees < ActiveRecord::Migration
  def self.up
    add_index :attendees, :reg_id
  end

  def self.down
    remove_index :attendees, :reg_id
  end
end
