class RemoveWorkForPieFromAttendees < ActiveRecord::Migration
  def self.up
    remove_column :attendees, :work_for_pie_id
  end

  def self.down
    add_column :attendees, :work_for_pie_id, :string
  end
end
