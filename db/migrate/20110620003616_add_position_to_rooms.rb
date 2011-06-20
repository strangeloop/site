class AddPositionToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :position, :integer
  end

  def self.down
    remove_column :rooms, :position
  end
end
